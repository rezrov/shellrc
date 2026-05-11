<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# kitty/linux

## Purpose
Linux-specific kitty configuration. Selected automatically when `KITTY_CONFIG_DIRECTORY=$HOME/.shellrc/kitty/linux`
(exported by `../../bash_system_envs.bash`). Hardcodes distro-standard binary paths: `/bin/bash` and `/usr/bin/fish`.

## Key Files

| File | Description |
|------|-------------|
| `kitty.conf` | `include`s the user's `~/.config/kitty/kitty.conf` first, then sets `shell /bin/bash -i -c "exec /usr/bin/fish"`. The `font_family`, `font_size`, scrollback, padding, and theme lines are present but commented out. |

## For AI Agents

### Working In This Directory

- **The `include ~/.config/kitty/kitty.conf` line is intentional** — it lets users keep machine-local kitty tweaks (window size, theme variants) outside the repo, and our config layers on top. Don't remove it.
- **`shell /bin/bash -i …`** uses the distro bash (no login flag, unlike macOS). If the user's distro packages bash elsewhere, they'll need to override this — do not silently change the path.
- **`exec /usr/bin/fish`** assumes fish is installed at the standard location. If you parameterize this, do it via the user's `~/.config/kitty/kitty.conf` override, not here.
- **Selected by env var, not symlink.** Unlike macOS, no symlink dance is required — the `KITTY_CONFIG_DIRECTORY` mechanism handles selection. But systemd/desktop-launcher quirks may bypass `~/.profile`; the root `README.md` documents the `~/.xprofile` workaround.
- **Cosmetic defaults stay commented.** Keep `font_family`, `background`, etc. commented so a user without Nerd Fonts gets a working terminal on first launch.

### Testing Requirements

```bash
echo "$KITTY_CONFIG_DIRECTORY"             # expect: …/shellrc/kitty/linux
kitty --debug-config 2>&1 | grep -i shell  # confirms the shell directive parsed
```

Restart kitty (close all windows) after edits; some directives apply only at launch.

### Common Patterns

- Single `kitty.conf`; no helper scripts.
- `include` then override: user file first, then our directives.

## Dependencies

### Internal

- `../../bash_system_envs.bash` — sets `KITTY_CONFIG_DIRECTORY` so kitty picks this directory.
- `../../fonts/` — referenced (commented) by `font_family`.

### External

- kitty terminal emulator on Linux.
- `/bin/bash` (distro bash, version irrelevant — only used to exec fish).
- `/usr/bin/fish`.

<!-- MANUAL: -->
