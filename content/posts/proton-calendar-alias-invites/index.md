---
title: "Fixing Alias-Based Calendar Invites in Proton Calendar"
date: 2026-07-03
draft: false
summary: "A small local service that turns alias-addressed calendar invites into non-RSVP .ics copies Proton Calendar can import."
tags: ["proton-mail", "calendar", "email", "python", "duckdb", "local-first"]
---

I ran into a small but annoying calendar problem.

I use email aliases on a custom domain and forward them into one Proton Mail inbox. Mail works fine. Calendar invites are where things get weird: the invite is addressed to the alias, but Proton Calendar expects the attendee to be the main Proton address. The result is an invite that arrives in mail, but is awkward or impossible to add/respond to cleanly in Proton Calendar.

I do not actually care about RSVP support for these invites. I just want the event on my calendar.

So the solution was to make a local normalizer: read the invite from Proton Mail, remove all RSVP/attendee semantics, convert the calendar file into a plain published event, and email that cleaned `.ics` file back to myself.

## The shape of the problem

{{< mermaid >}}
flowchart LR
    A[Organizer sends invite] --> B[Alias address]
    B --> C[Proton Mail inbox]
    C --> D{Proton Calendar import}
    D -->|attendee is alias| E[Awkward / broken invite handling]
{{< /mermaid >}}

The key detail is that the `.ics` file contains something like this:

```ics
BEGIN:VCALENDAR
METHOD:REQUEST
BEGIN:VEVENT
UID:example-event-id
ORGANIZER;CN=Organizer:mailto:organizer@example.com
ATTENDEE;CN=Me;RSVP=TRUE;PARTSTAT=NEEDS-ACTION:mailto:alias@example.net
SUMMARY:Meeting
DTSTART:20260710T180000Z
DTEND:20260710T183000Z
END:VEVENT
END:VCALENDAR
```

That `ATTENDEE` line is the problem. It says the invited attendee is the alias address. Proton Calendar quite reasonably treats it like an invite for that identity, not a normal event for the main mailbox.

## The local-only fix

The normalizer runs locally and talks to Proton through [Proton Mail Bridge](https://proton.me/mail/bridge), which exposes local IMAP and SMTP ports. No Proton private APIs, no web scraping, no cloud service, and no SimpleLogin API needed.

{{< mermaid >}}
flowchart TD
    Bridge[Proton Mail Bridge]
    IMAP[Local IMAP]
    Service[alias-invite-normalizer]
    DuckDB[(DuckDB state)]
    SMTP[Local SMTP]
    Inbox[Proton inbox]
    Calendar[Proton Calendar]

    Bridge --> IMAP --> Service
    Service -->|dedupe key + hashes| DuckDB
    Service -->|clean METHOD:PUBLISH .ics| SMTP --> Bridge --> Inbox
    Inbox --> Calendar
{{< /mermaid >}}

The service watches configured mailboxes, finds `text/calendar` parts or `.ics` attachments, parses them with a real iCalendar parser, and checks for attendees on configured alias domains.

The output is intentionally not an RSVP-able invite:

```ics
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Alias Invite Normalizer//EN
METHOD:PUBLISH
BEGIN:VEVENT
UID:example-event-id
ORGANIZER;CN=Organizer:mailto:organizer@example.com
SUMMARY:Meeting
DTSTART:20260710T180000Z
DTEND:20260710T183000Z
COMMENT:Original invite was sent to alias alias@example.net. This is a non-RSVP calendar copy.
END:VEVENT
END:VCALENDAR
```

The important transformations are:

- change `METHOD:REQUEST` or `METHOD:CANCEL` to `METHOD:PUBLISH`
- remove every `ATTENDEE` property
- drop RSVP/participant-response semantics
- keep useful event fields like `SUMMARY`, `DESCRIPTION`, `LOCATION`, `DTSTART`, `DTEND`, `ORGANIZER`, recurrence rules, timezones, and alarms
- add a note explaining that this is a non-RSVP copy

## Configuration

The config is boring on purpose:

```yaml
proton:
  imap_host: "127.0.0.1"
  imap_port: 1143
  imap_security: "starttls"
  smtp_host: "127.0.0.1"
  smtp_port: 1025
  smtp_security: "starttls"
  bridge_username: "${PROTON_BRIDGE_USERNAME}"
  bridge_password: "${PROTON_BRIDGE_PASSWORD}"
  master_email: "me@example.com"
  sender_email: "me@example.com"
  mailboxes:
    - "INBOX"

aliases:
  domains:
    - "example.net"

database:
  backend: "duckdb_file"
  path: "./alias_invite_state.duckdb"

behavior:
  poll_interval_seconds: 60
  mark_original_as_seen: false
  send_companion_email: true
  store_raw_ics: false
```

Secrets stay in environment variables. The local config and DuckDB file do not need to be committed anywhere.

## Dedupe matters

The service stores processed invite state in DuckDB. The logical key is:

```text
(event_uid, recurrence_id, sequence, original_method, alias_email)
```

It also stores hashes of the original and generated `.ics`. That gives it a few useful behaviors:

- same event, same sequence, same hash: skip
- same event key, different hash: warn, but do not spam another email
- new sequence: send a new copy
- cancellation: generate a non-RSVP cancellation copy, still never reply to the organizer

## The CLI

The whole thing is a small Python CLI:

```bash
alias-invite-normalizer init-db
alias-invite-normalizer doctor
alias-invite-normalizer scan-once
alias-invite-normalizer run
```

`doctor` checks config, DuckDB, IMAP login, and SMTP login. `scan-once` processes current mail and exits. `run` stays in the foreground and polls.

I also wrapped it locally with a shorter command:

```bash
pen doctor
pen scan-once
pen run
```

The wrapper just loads a local `.env`, points at the local YAML config, and runs the normalizer.

## Why this feels like the right amount of software

This is not a calendar server. It is not a replacement for Proton Calendar. It does not pretend RSVP works. It just turns a problematic invite into a plain event copy that Proton Calendar can add.

That constraint keeps the design small:

- local-only
- Proton Bridge for supported IMAP/SMTP access
- DuckDB for state
- no external listener
- no organizer or attendee emails
- no raw invite content in logs

The best part is that the workflow is now boring. If an invite lands in the inbox for an alias, the service sends back a cleaned calendar copy. I add that copy to Proton Calendar and move on with my day.
