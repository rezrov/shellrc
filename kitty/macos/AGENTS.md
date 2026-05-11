<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# kitty/macos

## Purpose
macOS-specific kitty configuration. Used via a manual symlink: `~/.config/kitty/kitty.conf` →
`~/.shellrc/kitty/macos/kitty.conf`. Hardcodes Homebrew binary paths: `/opt/homebrew/bin/bash` and
`/opt/homebrew/bin/fish` (Apple Silicon; Intel Macs are not supported).

## Key Files

| File | Description |
|------|-------------|
| `kitty.conf` | Sets `shell /opt/homebrew/bin/bash -li -c "exec /opt/homebrew/bin/fish"` so bash builds the env, then execs fish. `font_family`, `font_size`, scrollback, padding, theme lines are present but commented out. |

## For AI Agents

### Working In This Directory

- **Symlinked, not env-selected.** Unlike Linux, macOS uses a manual `ln -sf ~/.shellrc/kitty/macos/kitty.conf ~/.config/kitty/kitty.conf` (see root `README.md`). Reason: GUI-launched kitty on macOS doesn't inherit shell env vars, so `KITTY_CONFIG_DIRECTORY` wouldn't be set when kitty starts.
- **No `include` line.** Because this file *is* the symlink target at `~/.config/kitty/kitty.conf`, including itself would loop. Machine-local tweaks should go in `~/.shellrc/bash_local_interactive.bash` (env vars kitty respects) or live in a separate `kitty.local.conf` users `include` from this file manually.
- **`bash -li` (login + interactive) is required.** macOS GUI-launched processes don't get a login shell automatically, so we force one here to pick up `/opt/homebrew/bin` on PATH and the rest of the env construction.
- **Hardcoded Homebrew prefix `/opt/homebrew`.** Apple Silicon only. Don't add Intel Mac (`/usr/local`) fallbacks unless explicitly asked.
- **Cosmetic defaults stay commented** so users without Nerd Fonts still get a working terminal on first launch.

### Testing Requirements

After edits, **fully quit kitty** (right-click the menu-bar icon → Quit; not just close windows) and relaunch:

```bash
ls -l ~/.config/kitty/kitty.conf            # confirm the symlink
kitty --debug-config 2>&1 | grep -i shell   # confirms shell directive parsed
```

### Common Patterns

- Single `kitty.conf`; no helper scripts.
- Hardcoded Homebrew paths (Apple Silicon).

## Dependencies

### Internal

- `../../bash_system_paths.bash` / `../../bash_interactive_paths.bash` — Homebrew PATH setup that the spawned `bash -li` relies on.
- `../../fonts/` — referenced (commented) by `font_family`.

### External

- kitty terminal emulator on macOS (Homebrew `kitty`).
- Homebrew `bash` at `/opt/homebrew/bin/bash` (system `/bin/bash` is too old).
- Homebrew `fish` at `/opt/homebrew/bin/fish`.

<!-- MANUAL: -->
