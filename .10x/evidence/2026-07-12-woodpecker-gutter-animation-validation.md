Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-woodpecker-gutter-animation.md, .10x/specs/woodpecker-gutter-animation.md

# Woodpecker gutter animation validation

## What was observed

- The supplied source `assets/img/acorn-woodpecker-sprite-sheet.png` is 1983×793 pixels and has no alpha channel.
- A local derived asset, `assets/img/acorn-woodpecker-sprite.png`, is 1985×794 pixels (five 397px columns by two 397px rows) and has an alpha channel.
- `hugo --cleanDestinationDir` succeeded with Hugo v0.160.1 and built 159 pages.

## Procedure

1. Inspected the source with `sips -g hasAlpha -g pixelWidth -g pixelHeight`.
2. Derived the normalized sprite sheet with:

   ```sh
   magick assets/img/acorn-woodpecker-sprite-sheet.png \
     -alpha off -fuzz 12% -transparent '#f8f8f8' \
     -gravity northwest -background none -extent 1985x794 \
     assets/img/acorn-woodpecker-sprite.png
   ```

3. Added a homepage-only decorative layer with separate fixed left and right gutter clips. JavaScript measures `document.body` to set those clips, cycles frames 0–7 during one 3.2-second flight after a 1.2-second delay, and uses frame 9 as the static perch.
4. Applied a desktop threshold of 1024px and a 160px minimum gutter width per side. The layer is `aria-hidden`, has `pointer-events: none`, and shows only the static perch when reduced motion is requested.
5. Ran `hugo --cleanDestinationDir`.

## Viewport verification and correction

A first 2000×1100 headless Chrome screenshot after six seconds showed the perched bird inside the body runner near x=480, while the runner began around x=360. The fixed gutter descendants were positioned relative to `body`, because the runner’s `backdrop-filter` establishes a containing block. The original code incorrectly set gutter positions relative to the viewport.

The correction sets the left gutter to `-runner.left` and the right gutter to `runner.width`, both relative to the body runner. After rebuilding with `hugo --cleanDestinationDir`, two six-second Chrome captures at the same viewport reported:

| Mode | Bird bounding box | Runner bounds | Result |
| --- | --- | --- | --- |
| Normal motion | x=82.88–218.88, y=217.91 | x=356–1636 | Bird entirely in the left gutter after the one-time flight |
| `prefers-reduced-motion: reduce` | x=82.88–218.88, y=217.91 | x=356–1636 | Static perch only; bird entirely in the left gutter |

Screenshots:

- `.10x/evidence/.storage/2026-07-12-woodpecker-desktop-2000x1100-after-6s.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-reduced-motion-2000x1100-after-6s.png`

## What this supports

The implementation uses local assets only, keeps the bird out of the measured content runner, completes the one-time flight by six seconds, and has a no-flight reduced-motion branch.

## Limits

The source background was flattened. The 12% color-fuzz transparency removal preserves the clearly visible pale markings in the derived preview, but may leave subtle light halo artifacts at some feather edges.
