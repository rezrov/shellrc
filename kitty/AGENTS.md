<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# kitty

## Purpose
Per-OS kitty terminal emulator configurations. Split into `macos/` and `linux/` subdirectories because the path to the bash and fish binaries differs (`/opt/homebrew/bin/...` on macOS, `/bin/bash` and `/usr/bin/fish` on Linux). The parent `bash_system_envs.bash` exports `KITTY_CONFIG_DIRECTORY="$HOME/.shellrc/kitty/$OS_TYPE"` so kitty picks the correct variant automatically — except on macOS, where (per README.md) the env var isn't propagated into the kitty process and a manual symlink is required.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `macos/` | kitty.conf for macOS (Homebrew bash and fish paths). See `macos/AGENTS.md` |
| `linux/` | kitty.conf for Linux (system bash and fish paths, with an `include` of the user's existing `~/.config/kitty/kitty.conf` so distro/system settings layer underneath). See `linux/AGENTS.md` |

## For AI Agents

### Working In This Directory

- Both configs use the kitty `shell` directive to launch bash with `-li -c "exec /path/to/fish"`. This is the mechanism that lets bash construct the environment (via `profile.bash` → `bashrc.bash`) before fish takes over.
- macOS uses `bash -li` (login + interactive); Linux uses `bash -i` (interactive only). The macOS variant uses `-li` because GUI-launched kitty doesn't go through a login shell otherwise, so env vars set in `bash_local_envs.bash` would be missing.
- Most cosmetic settings (`font_family`, `font_size`, `scrollback_lines`, etc.) are commented out — users opt in by uncommenting after installing fonts. Don't uncomment them by default.
- The Linux config `include`s `~/.config/kitty/kitty.conf` at the top, layering distro defaults underneath repo overrides. macOS does not, because the macOS install procedure replaces `~/.config/kitty/kitty.conf` with a symlink to this file (which would create a circular include).

### Testing Requirements

- `kitty --debug-config` prints the resolved configuration; use it to verify the right shell binary is being invoked.
- Confirm kitty actually launches by quitting all kitty windows and opening a fresh one. If kitty silently exits, the `shell` directive is the most likely culprit (bad path).

### Common Patterns

- `KITTY_CONFIG_DIRECTORY` is the env var that selects which subdir kitty reads from on Linux. macOS users symlink instead, per README.md.
- On Linux, `KITTY_CONFIG_DIRECTORY` is exported by `bash_system_envs.bash` only if some shell has sourced `~/.profile` (or `~/.bashrc`) in the user's session. Desktop launchers under systemd-managed user sessions can launch kitty without that env var being present — the documented mitigation is `source ~/.profile` from `~/.xprofile`. See README.md "Linux users" note in the install section.

## Dependencies

### Internal

- `../bash_system_envs.bash` exports `KITTY_CONFIG_DIRECTORY` based on `OS_TYPE`.
- `../profile.bash` and `../bashrc.bash` — the scripts the `shell` directive transitively executes.
- `../fonts/` — bundled fonts referenced (commented) in both kitty.conf files.

### External

- kitty terminal emulator (https://sw.kovidgoyal.net/kitty/).
- bash and fish at the paths hardcoded in each config.

<!-- MANUAL: -->
