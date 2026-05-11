<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-04 | Updated: 2026-05-04 -->

# bin

## Purpose
Helper scripts intended to be runnable via PATH. The parent `bash_interactive_paths.bash` includes a commented-out template (`prepend_to_path "$HOME/.shellrc/bin"`) so users can opt this directory into their PATH. Currently holds only the bash→fish alias translator.

## Key Files

| File | Description |
|------|-------------|
| `fish_aliases.bash` | Sources `~/.shellrc/bash_aliases.bash` and emits each `alias` definition reformatted as fish syntax (`alias NAME 'BODY'`). Invoked from `config.fish` via `eval (~/.shellrc/bin/fish_aliases.bash)`. Marked executable. |

## For AI Agents

### Working In This Directory

- `fish_aliases.bash` is a string-translation bridge: it relies on the bash `alias` builtin's output format and a regex (`^alias ([^=]+)=.(.+).$`) to extract names and bodies. If you change quoting or escaping in `bash_aliases.bash`, re-run `bash ~/.shellrc/bin/fish_aliases.bash` and confirm the output is valid fish.
- Aliases whose body is not valid fish syntax (e.g., bash-specific `$()`, arrays, `[[ ]]`) will be silently emitted but break fish on eval. The convention is to push such logic into a paired bash function + fish function rather than aliasing.
- This directory is not on PATH by default — the user must opt in by editing `bash_interactive_paths.bash`. New scripts placed here should not assume PATH membership.

### Testing Requirements

- Run `bash ~/.shellrc/bin/fish_aliases.bash` and inspect the output for malformed lines.
- Smoke-test by piping into a transient fish session: `fish -c "$(bash ~/.shellrc/bin/fish_aliases.bash)"`.

### Common Patterns

- Scripts here use `#!/bin/bash` shebangs and source other `~/.shellrc/*.bash` files to reuse functions/aliases rather than duplicating logic.

## Dependencies

### Internal

- `../bash_aliases.bash` — the source of truth for aliases that this script translates.
- `../config.fish` — the consumer that evals this script's output at fish startup.

### External

- GNU bash (for the `alias` builtin output format and regex matching with `=~`).

<!-- MANUAL: -->
