<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# fonts

## Purpose
Bundled patched monospace fonts for the Tier-3 (kitty + Nerd Fonts) experience. Ships JetBrains Mono Nerd Font Mono in
four weights so users have a working font available without a separate Nerd Fonts install. Referenced (commented out) by
the `font_family` line in `kitty/macos/kitty.conf` and `kitty/linux/kitty.conf`.

## Key Files

| File | Description |
|------|-------------|
| `JetBrainsMonoNerdFontMono-Regular.ttf` | Regular weight. |
| `JetBrainsMonoNerdFontMono-Bold.ttf` | Bold weight. |
| `JetBrainsMonoNerdFontMono-Italic.ttf` | Italic. |
| `JetBrainsMonoNerdFontMono-BoldItalic.ttf` | Bold italic. |
| `README.md` | One-paragraph note pointing at upstream Nerd Fonts repo. |

## For AI Agents

### Working In This Directory

- **Binary assets — don't try to edit TTFs.** Replace whole files if you're updating to a newer Nerd Fonts release; don't attempt patch-level edits.
- **Install is a manual user step.** The fonts are not auto-installed by anything in this repo; `README.md` (root) documents how to install them per-OS (Font Book on macOS; `~/.local/share/fonts/` + `fc-cache -fv` on Linux).
- **Optional tier.** Tier-1 (bash only) and Tier-2 (bash + fish) users may not install these. Don't make any non-kitty config require a Nerd Font.
- **Kitty references are commented out by default** (`# font_family JetBrainsMono Nerd Font Mono` in both `kitty.conf` files). Users uncomment after installing.
- **Source.** Files originate from https://github.com/ryanoasis/nerd-fonts (the `patched-fonts/JetBrainsMono` directory). Match the upstream filename style if adding more weights/variants.

### Testing Requirements

After OS-level install, verify with:

```bash
# macOS
fc-list 2>/dev/null | grep -i "JetBrainsMono Nerd Font" || \
    system_profiler SPFontsDataType | grep -i jetbrainsmono
# Linux
fc-list | grep -i "JetBrainsMono Nerd Font"
```

Then uncomment `font_family` in the appropriate `kitty/<os>/kitty.conf` and restart kitty.

### Common Patterns

- One TTF per weight; no font-config XML or installer scripts.

## Dependencies

### Internal

- Referenced (commented) by `../kitty/macos/kitty.conf` and `../kitty/linux/kitty.conf`.

### External

- Upstream: [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts), JetBrains Mono variant.

<!-- MANUAL: -->
