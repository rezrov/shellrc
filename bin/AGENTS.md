<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-05-10 | Updated: 2026-05-10 -->

# bin

## Purpose
Helper scripts invoked at shell startup. Currently a single script: `fish_aliases.bash`, the bridge that lets fish reuse
the bash-defined aliases in `bash_aliases.bash` without duplicating them.

## Key Files

| File | Description |
|------|-------------|
| `fish_aliases.bash` | Sources `~/.shellrc/bash_aliases.bash`, walks every `alias` the bash builtin emits, decodes bash's `'\''`-escaped single quotes, re-encodes for fish (only `\\` and `\'` need escaping inside fish single-quoted strings), and prints `alias name 'body'; …` for `config.fish` to `eval`. Marked executable. |

## For AI Agents

### Working In This Directory

- **`fish_aliases.bash` is invoked, not sourced.** `config.fish` runs `eval (~/.shellrc/bin/fish_aliases.bash)`, capturing stdout. Anything other than alias-emitting `printf` lines pollutes that eval, so don't add stray `echo`/log output.
- **The quoting logic is load-bearing.** Bash's `alias` builtin always wraps values in single quotes and renders embedded single quotes as `'\''`; fish's single-quoted strings only honor `\\` and `\'`. The translation order in the script (decode bash → escape backslash → escape apostrophe) matters — don't reorder.
- **Keep aliases fish-compatible upstream.** If an alias in `bash_aliases.bash` uses bash-only syntax (`$()`, arrays, `[[ … ]]`), the fish side will silently inherit broken syntax. Prefer paired functions in `bash_functions_custom.bash` + `fish_functions_custom.fish` when an alias can't be expressed in both shells.
- **Don't add a fish shebang.** The script is bash (`#!/usr/bin/env bash`) on purpose — it relies on bash's `alias` builtin and `BASH_REMATCH`.
- **PATH inclusion is opt-in.** `bash_interactive_paths.bash` has a commented-out `prepend_to_path "$HOME/.shellrc/bin"`. New scripts here are not on `$PATH` for users by default.

### Testing Requirements

```bash
~/.shellrc/bin/fish_aliases.bash | head      # sanity-check the fish alias output
fish -ic 'alias | head'                       # confirm fish actually picks them up
```

### Common Patterns

- Single-purpose, idempotent shell scripts that get invoked at shell startup.

## Dependencies

### Internal

- `../bash_aliases.bash` — source of truth for aliases.
- `../config.fish` — the consumer that `eval`s this script's output.

### External

- GNU bash 4+ (uses `BASH_REMATCH`, parameter substitution).

<!-- MANUAL: -->
