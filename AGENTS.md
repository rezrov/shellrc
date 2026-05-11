<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# shellrc

## Purpose
Cross-platform (macOS / Linux / WSL) bash + fish shell configuration that produces a consistent, richly-colored interactive
shell across machines. The repo is meant to be cloned to `~/.shellrc` and symlinked into `~/.bashrc`, `~/.profile`, and
`~/.config/fish/config.fish`. Bash drives the environment construction (envs, PATH, OS detection, color setup); fish
inherits that environment and adds its own functions and a translated alias bridge. Optional kitty terminal configs and
bundled JetBrains Mono Nerd Fonts complete the three-tier (bash / +fish / +kitty+nerd-fonts) adoption story.

## Key Files

| File | Description |
|------|-------------|
| `README.md` | User-facing install + tour. The canonical narrative for what each file does and how the pieces fit. |
| `LICENSE.txt` | GPL-3.0 license text. |
| `.gitignore` | Ignores `.idea/`, `.DS_Store`, `.omc/`, and `bash_local_*.bash` host-specific override files. |
| `bashrc.bash` | Entry point for interactive bash; symlinked from `~/.bashrc`. Sources functions, envs, paths, aliases, colors, then optional `bash_local_interactive.bash`. |
| `profile.bash` | Entry point for login bash; symlinked from `~/.profile`. Branches on interactive vs. non-interactive: interactive sources `bashrc.bash`; non-interactive sources only system envs + paths. |
| `bash_functions.bash` | Defines `set_os_type` (sets `OS_TYPE` to `macos`/`linux`/`wsl`), `is_interactive_shell`, `iecho`, `prepend_to_path`, `log_sourcing`, and ssh-agent helpers (`sshagent_init` etc.). Idempotency guard via `declare -f set_os_type`. Sources `bash_functions_custom.bash` if present. |
| `bash_functions_custom.bash` | User extension point for custom bash functions. Currently ships `rmts` (strip trailing whitespace), `r` (background a command via `screen`), `gen_rand` (random password), and the `sshagent_*` family. |
| `bash_aliases.bash` | All shell aliases. Branches on `OS_TYPE`. Re-exported into fish via `bin/fish_aliases.bash`, so aliases must use fish-compatible syntax (no `$()`, no arrays). |
| `bash_system_envs.bash` | Env vars (no PATH) for both interactive and non-interactive shells. Sets `KITTY_CONFIG_DIRECTORY`, `MOUNT_DIR`. Sources optional `bash_local_system.bash` at the end. |
| `bash_system_paths.bash` | PATH modifications for all shells. macOS branch dynamically prepends every `/opt/homebrew/opt/*/libexec/{gnubin,uubin}` directory plus Homebrew sbin/bin and sets MANPATH/INFOPATH. |
| `bash_interactive_envs.bash` | Interactive-only env: `histappend`, `checkwinsize`, `HISTSIZE`, `HISTCONTROL`, `TZ`, `EDITOR` autodetect, `umask`, Homebrew prefix vars on macOS. |
| `bash_interactive_paths.bash` | Interactive-only PATH (commented templates for `~/.shellrc/bin`, `npm`, `pnpm`). Sources `bash_system_paths.bash` first. |
| `bash_set_colors.bash` | Centralized color setup: `LS_COLORS` (via `dircolors ~/.shellrc/dircolors` with embedded fallback), `LSCOLORS` for BSD ls, tput-gated colored `PS1`, and `FORCE_COLOR=true`. **Hot path** — touched often. |
| `dircolors` | Solarized 256-color GNU dircolors source for `LS_COLORS`. After editing, regenerate the embedded fallback in `bash_set_colors.bash` with `dircolors -b ~/.shellrc/dircolors`. |
| `config.fish` | Fish entry point; symlinked from `~/.config/fish/config.fish`. Promotes `$HOME`-rooted PATH dirs to the front, sources `fish_functions.fish`, evals `bin/fish_aliases.bash` output, and runs `fish_logo` if installed. Modifications go inside the labeled block. |
| `fish_functions.fish` | Fish equivalents of bash helpers (`prepend_to_path`, `log_sourcing`). Idempotent via `functions -q prepend_to_path`. Sources `fish_functions_custom.fish`. |
| `fish_functions_custom.fish` | Fish ports of `rmts`, `r`, `gen_rand`, plus `d2u` (strip CR). |
| `gitinclude` | Git config fragment users include from `~/.gitconfig` to share aliases/whitespace/color settings across machines. |
| `bash-startup.png` | Diagram of bash startup file ordering, referenced from `README.md`. |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `bin/` | Helper scripts invoked at shell startup. Currently just `fish_aliases.bash`, the bash→fish alias bridge (see `bin/AGENTS.md`). |
| `fonts/` | Bundled JetBrains Mono Nerd Font TTFs (see `fonts/AGENTS.md`). |
| `kitty/` | Per-OS kitty terminal configs under `linux/` and `macos/` subdirs (see `kitty/AGENTS.md`). |

## For AI Agents

### Working In This Directory

- **Edit the repo, not the live copy.** This repo lives at `/Users/ron/save/projects/shellrc/`; the user's active configuration is at `~/.shellrc`, which has machine-local customizations. Never write to `~/.shellrc` from here.
- **Three-tier adoption philosophy.** Tier 1 = bash only; Tier 2 = bash + fish; Tier 3 = bash + fish + kitty + Nerd Fonts. Don't make a Tier-1 file depend on a fish/kitty/Nerd-Font feature; gate higher-tier behavior so dropping back is harmless.
- **Respect the "MODIFICATIONS BELOW THIS LINE" markers.** Files with that marker have a header block users are told never to edit; new logic goes below it. Files marked "do not modify" (`bash_functions.bash`, `bashrc.bash`, `profile.bash`, `fish_functions.fish`, `bin/fish_aliases.bash`) should only change for genuine framework-level fixes, not user-style tweaks.
- **`OS_TYPE` is the platform switch.** Always available after `set_os_type` runs. Values: `macos`, `linux`, `wsl`. Use it instead of re-detecting via `uname`.
- **Aliases must be fish-compatible.** Anything in `bash_aliases.bash` is parsed by `bin/fish_aliases.bash` and re-emitted as fish aliases. Avoid bash-only constructs (`$(…)`, arrays, `[[ … ]]`); if you need them, write paired functions in `bash_functions_custom.bash` and `fish_functions_custom.fish` instead.
- **Apple Silicon only on macOS.** Hardcoded `/opt/homebrew` prefix throughout. Don't add Intel-Mac (`/usr/local`) fallbacks unless explicitly asked.
- **Idempotency guards.** `bash_functions.bash` and `fish_functions.fish` use `declare -f` / `functions -q` checks so re-sourcing is a no-op. Preserve this pattern when adding to those files.
- **Host-local overrides are gitignored.** `bash_local_system.bash` (sourced from `bash_system_envs.bash`) and `bash_local_interactive.bash` (sourced from `bashrc.bash`) are the supported escape hatches for per-machine secrets/paths. Never check them in.
- **Color regeneration.** Edits to `dircolors` need a follow-up `dircolors -b ~/.shellrc/dircolors` to refresh the embedded fallback in `bash_set_colors.bash`.

### Testing Requirements

There are no automated tests. Smoke-test by sourcing a fresh shell and looking for breakage:

```bash
bash -lic 'echo "$OS_TYPE $PS1"; type ls grep; alias ef'
fish -ic 'functions -q rmts; alias | head'
```

For PATH/env changes, also run a non-interactive shell to confirm the non-interactive branch of `profile.bash` still works:

```bash
bash -c 'echo $PATH'
```

For kitty config changes, restart kitty (don't just `kitty @ load-config`; some directives only apply at launch).

### Common Patterns

- Sourcing chain: file always begins with `source "$HOME/.shellrc/bash_functions.bash"` and `set_os_type` before doing anything OS-specific.
- `iecho` is the project's "log only when interactive" helper — use it for startup messages instead of bare `echo`.
- `prepend_to_path` (bash) / `prepend_to_path` (fish) — never push to PATH by hand; always go through these so duplicates are skipped.
- Symlink-first install model: any new top-level config file should be designed to be symlinked from its canonical location (e.g., `~/.bashrc` → `bashrc.bash`).

## Dependencies

### External

- **GNU bash 4+** (Homebrew `bash` on macOS — system `/bin/bash` is too old; `set_os_type` warns).
- **GNU coreutils / sed / tar / grep / findutils** (Homebrew `gnu-sed`, `gnu-tar`, `grep`, `findutils`, `uutils-coreutils`) — several aliases and functions use GNU-only flags; `bash_system_paths.bash` puts them on PATH.
- **fish** (optional, Tier 2+).
- **kitty** + `kitty-terminfo` (optional, Tier 3).
- **Nerd Fonts** (optional, Tier 3) — JetBrains Mono variants bundled in `fonts/`.
- **Fisher + Tide** (optional fish plugin manager + prompt; install instructions in `README.md`).
- **screen** — used by the `r` background-runner function.

<!-- MANUAL: -->
