<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# kitty

## Purpose
Per-OS configuration for the [kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator. Split into `macos/` and `linux/`
because the path to bash and fish differs by platform (Homebrew vs. distro-managed). The Linux config is selected
automatically via the `KITTY_CONFIG_DIRECTORY` env var exported from `../bash_system_envs.bash`; macOS users symlink
`macos/kitty.conf` into `~/.config/kitty/kitty.conf` (see root `README.md` install steps).

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `linux/` | Linux kitty config; uses `/bin/bash` + `/usr/bin/fish` (see `linux/AGENTS.md`). |
| `macos/` | macOS kitty config; uses Homebrew `/opt/homebrew/bin/{bash,fish}` (see `macos/AGENTS.md`). |

## For AI Agents

### Working In This Directory

- **Tier-3 only.** Kitty is optional; Tier-1/2 users won't have it installed. Nothing here should be required by the bash/fish startup chain.
- **Two configs that intentionally diverge.** Don't merge them — the `shell` directive's binary paths are platform-specific. Shared defaults belong in user-level overrides (Linux's `kitty.conf` `include`s `~/.config/kitty/kitty.conf`); macOS doesn't have an `include` because it symlinks the OS-specific file directly into the canonical location.
- **`KITTY_CONFIG_DIRECTORY` selects the Linux config.** Set in `../bash_system_envs.bash` to `~/.shellrc/kitty/$OS_TYPE`. If you rename the subdirectories, update that file too.
- **Linux session-manager gotcha** (documented in root `README.md`): some desktops launch kitty without sourcing `~/.profile`, so `KITTY_CONFIG_DIRECTORY` is unset. Users add `source ~/.profile` to `~/.xprofile` to fix it.
- **The `shell` directive controls the bash→fish handoff.** It runs `bash -li` (login + interactive, so the full env construction happens) and then `exec fish`. Commenting it out reverts to the system default shell.
- **Font + cosmetic settings are intentionally commented out** so the Tier-1/2 install works without requiring Nerd Fonts. Keep new cosmetic options commented unless they're safe everywhere.

### Testing Requirements

After edits, fully restart kitty (some directives don't apply via `kitty @ load-config`). Quick sanity check:

```bash
kitty --debug-config 2>&1 | head -40    # shows which config kitty is reading
```

For Linux, also verify `KITTY_CONFIG_DIRECTORY` is set in the user's session env (otherwise kitty silently falls back to `~/.config/kitty/kitty.conf`).

### Common Patterns

- Each OS subdirectory holds exactly one `kitty.conf`.
- Defaults stay commented; users uncomment per machine.

## Dependencies

### Internal

- `../bash_system_envs.bash` — exports `KITTY_CONFIG_DIRECTORY`.
- `../fonts/` — JetBrains Mono Nerd Font, referenced by the commented `font_family` line.

### External

- [kitty terminal](https://sw.kovidgoyal.net/kitty/), `kitty-terminfo` package on remote hosts.
- GNU bash and fish at the platform-specific paths each `kitty.conf` hardcodes.

<!-- MANUAL: -->
