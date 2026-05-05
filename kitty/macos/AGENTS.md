<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# kitty/macos

## Purpose
kitty configuration for macOS. Hardcoded to Homebrew binary locations (`/opt/homebrew/bin/bash` and `/opt/homebrew/bin/fish`). The README.md install procedure asks users to symlink `~/.config/kitty/kitty.conf → ~/.shellrc/kitty/macos/kitty.conf` because the `KITTY_CONFIG_DIRECTORY` env var doesn't reach kitty when launched as a macOS GUI app.

## Key Files

| File | Description |
|------|-------------|
| `kitty.conf` | macOS kitty configuration. Sets `shell /opt/homebrew/bin/bash -li -c "exec /opt/homebrew/bin/fish"`. Cosmetic options (font, scrollback, padding, background) are commented out for the user to opt in. |

## For AI Agents

### Working In This Directory

- The `shell` directive uses `bash -li` (login + interactive). The login flag matters: it ensures `profile.bash` runs, which is what fully populates the environment before fish takes over.
- Paths assume Apple Silicon Homebrew (`/opt/homebrew`). For Intel Macs (`/usr/local`) or non-Homebrew installs, this file needs editing.
- Unlike `../linux/kitty.conf`, this file does NOT `include ~/.config/kitty/kitty.conf` — that path is the symlink target on macOS, so including it would create a cycle.
- Users may comment out the `shell` line entirely to fall back to their system default shell — preserve that as a documented option in any rewrites.

### Testing Requirements

- Quit kitty entirely (right-click menu-bar icon → Quit) before relaunching to test config changes; reloading isn't sufficient for `shell` directive changes.
- Verify Homebrew paths exist: `ls -la /opt/homebrew/bin/bash /opt/homebrew/bin/fish` before assuming they're valid.

### Common Patterns

- One-line `shell` directive that chains bash → fish via `exec`, so process tree shows fish (not bash → fish).

## Dependencies

### Internal

- `../../profile.bash` — entry point invoked because of `bash -li`.
- `../../bash_system_envs.bash` — sets `KITTY_CONFIG_DIRECTORY` (informational on macOS; not used by GUI kitty).

### External

- Homebrew (Apple Silicon prefix).
- bash and fish installed via Homebrew.

<!-- MANUAL: -->
