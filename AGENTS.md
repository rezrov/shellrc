<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# shellrc

## Purpose
Cross-platform interactive shell configuration that delivers a consistent experience across Linux and macOS. Bootstraps a bash environment, optionally hands off to fish shell, and ships matching kitty terminal configs and Nerd Fonts. The bash layer constructs the environment (PATH, env vars, aliases, colors, ssh-agent) so that fish — when launched — inherits everything.

## Key Files

| File | Description |
|------|-------------|
| `README.md` | Installation guide, file-by-file tour, and bash-startup explainer |
| `LICENSE.txt` | License text |
| `profile.bash` | Symlinked to `~/.profile`. Login-shell entry point: branches between interactive (sources `bashrc.bash`) and non-interactive (system envs/paths only) |
| `bashrc.bash` | Symlinked to `~/.bashrc`. Interactive entry point: initializes ssh-agent, sources local envs/paths/aliases/colors |
| `bash_functions.bash` | Foundational bash functions used by every other script (`set_os_type`, `is_interactive_shell`, `is_remote_shell`, `iecho`, `prepend_to_path`, `log_sourcing`). Self-guards against re-sourcing. Sources `bash_functions_custom.bash` if present |
| `bash_functions_custom.bash` | User-owned bash functions: `rmts`, `r` (screen backgrounder), `gen_rand`, and the `sshagent_*` family (only defined when `ssh-add` and `ssh-agent` are on PATH) |
| `bash_system_envs.bash` | Env vars for both interactive AND non-interactive shells. Sets `KITTY_CONFIG_DIRECTORY` per OS and `MOUNT_DIR` |
| `bash_system_paths.bash` | PATH modifications for both interactive AND non-interactive shells. macOS Homebrew GNU coreutils prepending lives here, gated on `/opt/homebrew/bin/brew` existence |
| `bash_local_envs.bash` | Env vars for interactive shells only: history sizing, `EDITOR`, `TZ`, `PS1`, umask, Homebrew paths |
| `bash_local_paths.bash` | PATH modifications for interactive shells only. Contains commented-out templates for adding `~/.shellrc/bin`, npm, and pnpm prefixes |
| `bash_aliases.bash` | Shell aliases (also consumed by fish via `bin/fish_aliases.bash`). OS-branched: macOS uses `ls -AFG`, Linux uses `ls -AF --color=always`, plus `bubu`, `kittyterm`, `ns`/`nsp`, `ef`, etc. |
| `bash_set_colors.bash` | `dircolors` evaluation (with embedded `LS_COLORS` fallback for systems without `dircolors`) and cursor-style/color escape codes for color terminals |
| `dircolors` | Solarized 256-color `dircolors` config, source: github.com/seebi/dircolors-solarized |
| `config.fish` | Symlinked to `~/.config/fish/config.fish`. Moves `$HOME`-rooted PATH entries to the front, sources `fish_functions.fish`, evals `bin/fish_aliases.bash`, and includes Oh My Fish hooks (colorman, fish_logo) |
| `fish_functions.fish` | Foundational fish functions (`prepend_to_path`, `log_sourcing`); always sources `fish_functions_custom.fish` |
| `fish_functions_custom.fish` | User-owned fish functions (`rmts`, `d2u`, `r`, `gen_rand`) |
| `gitinclude` | Personal git config to be pulled in via `[include] path = ~/.shellrc/gitinclude`. Defines aliases (`la`, `stat`, `lsi`, `lsu`, `diffb`, `diffc`, `diffd`, `hist`, `clite`, `addc`) and color settings |
| `bash-startup.png` | Diagram explaining bash startup precedence (referenced by README.md) |
| `.gitignore` | Ignores `.idea/` and `.DS_Store` |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `bin/` | Helper scripts on the install-time PATH (currently `fish_aliases.bash`, the bash→fish alias bridge). See `bin/AGENTS.md` |
| `fonts/` | JetBrains Mono Nerd Font TTFs, ready to install. See `fonts/AGENTS.md` |
| `kitty/` | Per-OS kitty terminal configs (macOS and Linux variants). See `kitty/AGENTS.md` |

## For AI Agents

### Working In This Directory

- **Never modify `bash_functions.bash`, `bashrc.bash`, `profile.bash`, or `fish_functions.fish` for user customizations.** Each file has a header comment indicating whether it is user-modifiable. User changes belong in the `*_custom.*` files or below the `MODIFICATIONS BELOW THIS LINE` markers.
- The `MODIFICATIONS BELOW THIS LINE` convention is load-bearing: it lets users merge upstream changes without conflicts. Preserve it when editing.
- Three split layers (system-vs-local × envs-vs-paths) intentionally separate what non-interactive shells see from what interactive shells see. Don't collapse them.
- `set_os_type` exports `OS_TYPE` as `macos`, `linux`, or `wsl`. Most cross-platform branching keys off this variable.
- `bash_functions.bash` gates everything on `declare -f set_os_type` to avoid re-sourcing side effects — preserve that guard if you touch it.
- Aliases authored in `bash_aliases.bash` must be syntactically valid for fish too (the `bin/fish_aliases.bash` regex translates them verbatim). Anything bash-only should live as a function in `bash_functions_custom.bash` and a parallel function in `fish_functions_custom.fish`.
- **Apple Silicon Macs only.** Homebrew paths are hardcoded to `/opt/homebrew`. Intel Macs are not supported. Non-Homebrew package managers will need adjustments — call this out rather than silently changing the prefix.
- `sshagent_*` functions are defined conditionally; do not assume `sshagent_init` exists. `bashrc.bash` already guards with `declare -f sshagent_init`.

### Testing Requirements

- This is a config repo, no test suite. Validate changes by:
  1. Sourcing modified files in a fresh bash subshell: `bash -ic 'source ~/.shellrc/bashrc.bash; echo OK'`
  2. For fish changes: `fish -ic 'echo OK'`
  3. Confirming the bash-to-fish alias bridge still produces valid fish syntax: `bash ~/.shellrc/bin/fish_aliases.bash`
- For PATH changes, verify both interactive and non-interactive paths: `bash -c 'source ~/.shellrc/profile.bash; echo $PATH'` vs. `bash -ic 'echo $PATH'`.
- For ssh-agent changes, the user-visible affordance is `ssh-add -l` after a fresh login.
- Set `BASH_LOG=/path/to/writable/file` to enable `log_sourcing` debug traces while diagnosing startup issues.

### Common Patterns

- Each script begins with `source "$HOME/.shellrc/bash_functions.bash"` and `set_os_type` to ensure `OS_TYPE` is available, regardless of source order. Re-sourcing is cheap because of the function-existence guard.
- `iecho` prints only in interactive shells — use it instead of bare `echo` for status messages so non-interactive sourcing stays silent.
- `prepend_to_path` (bash) and the fish equivalent both deduplicate before prepending; reuse them rather than mutating `PATH` directly.
- Cross-shell aliases live in `bash_aliases.bash`; cross-shell functions must be duplicated in both `bash_functions_custom.bash` and `fish_functions_custom.fish`.

## Dependencies

### External

- **GNU bash** (recent version, NOT macOS system bash). Installed via Homebrew on macOS.
- **fish shell** (optional) — invoked by kitty `shell` directive or via the `ef` alias.
- **kitty** (optional) — terminal emulator; configs in `kitty/`.
- **Nerd Fonts** (optional) — JetBrains Mono variants bundled in `fonts/`.
- **Homebrew** (macOS) — required for the GNU coreutils PATH prepends and the bundled `/opt/homebrew/bin/bash` and `/opt/homebrew/bin/fish` referenced by `kitty/macos/kitty.conf`.
- **Oh My Fish** (optional) — `config.fish` integrates `colorman` and `fish_logo` packages if installed.
- **dircolors** (GNU coreutils) — used by `bash_set_colors.bash`; falls back to a hardcoded `LS_COLORS` if unavailable.

<!-- MANUAL: Add personal notes below this line; they are preserved on regeneration -->
