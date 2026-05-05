<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# fonts

## Purpose
Bundled JetBrains Mono Nerd Font TTF files, ready for the user to install at the OS level. These are the patched monospace fonts that the kitty configs in `../kitty/` reference (commented-out `font_family JetBrainsMono Nerd Font Mono`). Source: https://github.com/ryanoasis/nerd-fonts.

## Key Files

| File | Description |
|------|-------------|
| `JetBrainsMonoNerdFontMono-Regular.ttf` | Regular weight |
| `JetBrainsMonoNerdFontMono-Bold.ttf` | Bold weight |
| `JetBrainsMonoNerdFontMono-Italic.ttf` | Italic |
| `JetBrainsMonoNerdFontMono-BoldItalic.ttf` | Bold italic |
| `README.md` | Notes pointing to the nerd-fonts upstream and explaining that ligatures are supported |

## For AI Agents

### Working In This Directory

- These are binary font assets — do not attempt to edit them. Replace by downloading new versions from nerd-fonts upstream.
- If swapping the bundled font family, also update the `font_family` line referenced (commented) in `../kitty/macos/kitty.conf` and `../kitty/linux/kitty.conf`, and update the README.md note here.
- Installation is OS-specific (macOS: drag into Font Book or copy to `~/Library/Fonts/`; Linux: copy to `~/.local/share/fonts/` and `fc-cache -fv`). Don't auto-install in shell startup — keep this manual.

### Testing Requirements

- After install, kitty needs a restart for the font to take effect. Verify with `kitty +list-fonts | grep -i jetbrains`.

### Common Patterns

- Fonts are committed to the repo (not gitignored) so the install flow works on a fresh clone without internet access.

## Dependencies

### External

- Nerd Fonts upstream (github.com/ryanoasis/nerd-fonts) — the canonical source for refreshing these binaries.

<!-- MANUAL: -->
