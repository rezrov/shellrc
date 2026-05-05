<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# kitty/linux

## Purpose
kitty configuration for Linux. Uses system-wide binary paths (`/bin/bash`, `/usr/bin/fish`). Layered on top of any user-level `~/.config/kitty/kitty.conf` via an `include` directive so distro defaults remain in effect underneath.

## Key Files

| File | Description |
|------|-------------|
| `kitty.conf` | Linux kitty configuration. Includes `~/.config/kitty/kitty.conf` first, then sets `shell /bin/bash -i -c "exec /usr/bin/fish"`. Cosmetic options commented out. |

## For AI Agents

### Working In This Directory

- The `shell` directive uses `bash -i` (interactive, NOT login). This works on Linux because the user's display manager / desktop session typically already runs a login shell up the tree, so `~/.profile` has already executed.
- The leading `include ~/.config/kitty/kitty.conf` means user-level kitty settings (themes, custom keybinds) layered there are preserved and overridden where needed by this file.
- Paths assume distro-standard locations. On Arch, NixOS, or other non-FHS-strict distros, `/usr/bin/fish` and `/bin/bash` may need adjustment.
- This file is selected automatically by kitty when the parent `bash_system_envs.bash` exports `KITTY_CONFIG_DIRECTORY="$HOME/.shellrc/kitty/linux"` — no symlinking required, unlike macOS.

### Testing Requirements

- After config changes, in an existing kitty window: `Ctrl+Shift+F5` reloads. For `shell` changes, restart kitty.
- Confirm the include path resolves: `kitty --debug-config | grep -i include`.

### Common Patterns

- Layer composition via `include` rather than wholesale replacement of the user's existing kitty config.

## Dependencies

### Internal

- `../../bash_system_envs.bash` — exports `KITTY_CONFIG_DIRECTORY=$HOME/.shellrc/kitty/linux` on Linux, which is how kitty finds this file.
- `../../profile.bash` / `../../bashrc.bash` — sourced transitively when bash starts.

### External

- bash at `/bin/bash`, fish at `/usr/bin/fish`.
- Optionally, a user-maintained `~/.config/kitty/kitty.conf` (gracefully skipped if missing).

<!-- MANUAL: -->
