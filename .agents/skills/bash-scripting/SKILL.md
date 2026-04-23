---
name: "bash-scripting"
version: "0.0.1"
description: "Bash style: `set -eE`, `log`/`fatal`, braced `${var}`, `trap` cleanup, `main()`. For `.sh` files and snippets. Do NOT use for non-POSIX shells."
license: "MIT"
metadata:
  author: "Leonid Bloch <lb.workbox@gmail.com>"
  tags:
    - bash
    - shell
    - scripting
    - style-guide
  languages:
    - bash
    - shell
  domain: software-engineering
---

# Bash Scripting Style Guide

## Instructions

- Apply the conventions in the sections below when creating or editing Bash/shell code. This covers both full Bash scripts (`.sh` files) and embedded snippets (for example a shell-out in a Python script, or a shell code sample in a README file).
- For embedded snippets, skip the structural boilerplate (`set -eE`, the `log`/`fatal`/`usage` helpers, and the `main()` entry point); apply only the style conventions (quoted `${var}`, `(( ))` arithmetic, `$()` over backticks, etc.).

## Purpose

Produce Bash scripts that are safe-by-default, readable, and consistent.

## Prerequisites

Target interpreter is Bash. The skill also applies to POSIX shells (`sh`, `dash`) with the bashisms listed under Limitations omitted or substituted.

## Limitations

Covers style conventions only; does not address performance tuning. Most conventions are POSIX-compatible and usable in `sh`; the following bashisms must be omitted or substituted when targeting POSIX `sh`:

- `set -E`: POSIX has only `set -e`; drop the `E`.
- `local` in functions: POSIX has no scoped variables; use unique names or unset on exit.
- `"${array[@]}"` array expansion: POSIX has no arrays; use positional parameters (`"${@}"`) or space-separated strings.

## Troubleshooting

- **Error:** `unbound variable` - **Cause:** typo or missing export - **Solution:** check the variable name; consider `: "${var:?required}"` to fail loudly.
- **Error:** trap fires repeatedly - **Cause:** nested `trap` calls - **Solution:** set a single trap at script start; do not re-register inside functions.

## Script Structure

Scripts should follow this order:

1. Shebang and set options
2. Helper functions (`log`, `fatal`, `usage`)
3. Argument parsing and validation
4. Main logic functions
5. `main()` function
6. Call to `main`

## Boilerplate

```bash
#!/bin/bash

set -eE

log() {
    >&2 printf "%s\n" "${*}"
}

fatal() {
    log "ERROR: ${*}"
    exit 1
}
```

## Variables

- Use lowercase with underscores: `source_tarball`, `output_dir`
- Always quote and use braces: `"${var}"` not `$var` or `"$var"`
- Use the `:?` assertion **only** when an unset/empty value would cause real harm (e.g. `rm -rf "${dir}/etc"` expanding to `rm -rf /etc`): `rm -rf "${dir:?required}/etc"`. For a standalone check, use `: "${dir:?required}"` (the `:` prevents executing the expanded value). Do **not** add `:?` when empty expansion is harmless (e.g. `rm -rf "${dir}"` - `rm -rf ""` is a no-op).

## Control Structures

Put `then`, `do` on separate lines:

```bash
if [ ! -f "${source_tarball}" ]
then
    fatal "File not found"
fi

for item in "${items[@]}"
do
    process "${item}"
done
```

## Functions

- Keep functions small and single-purpose
- Place all declarations, such as `local`, at the beginning of the function, before any logic
- Use `( )` subshells for scoped operations with `cd`
- Return early on errors with `fatal`

```bash
install_package() {
    (
        cd "${work_dir}"
        tar -zxf "${archive}"
        cd "${extracted_dir}"
        ./install.sh || fatal "Installation failed"
    )
}
```

## Cleanup

Use trap with comprehensive signal list:

```bash
work_dir="$(mktemp -d)"
trap 'rm -rf "${work_dir}"' EXIT HUP INT QUIT TERM
```

## Numeric Comparisons

Use arithmetic expressions `(( ))` for numeric comparisons, not `[ ]` with `-eq`/`-gt`/etc.:

```bash
if (( ${#array[@]} > 0 ))
then
    process_items
fi

(( retries != 0 )) || fatal "No retries left"
```

## Conditional Guards

`[ condition ] && action || fallback` is fine when there is a meaningful fallback.
When there is no fallback, use `[ ! condition ] || action` instead of `[ condition ] && action || true`:

```bash
# Good: clear intent, and if source fails it is not silently masked
[ ! -f "${HOME}/.bashrc" ] || . "${HOME}/.bashrc"

# Bad: || true masks errors from source itself
[ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc" || true

# Good: three-part form with a real fallback
[ -f "${config}" ] && . "${config}" || fatal "Config not found"
```

## Commands

- Use `$()` for command substitution, not backticks
- Use dash-prefixed short flags for `tar`: `tar -zxf` / `tar -ztf`, not `tar zxf`

## Main Function

End scripts with a `main()` function pattern:

```bash
main() {
    step_one
    step_two
    log "Done."
}

main
```

## Output

- For multi-line output, prefer `cat <<EOF` heredocs over multiple `echo`/`log` calls:

```bash
cat >&2 <<EOF
WARNING: something went wrong with ${component}.

  Possible fix:
    run_this_command --flag
EOF
```

## Logging

- Use `log` for informational messages (no "INFO:" prefix)
- Use `fatal` for errors (includes "ERROR:" prefix and exits)
- No `echo` for user-facing output; use the `log` function

## Examples

See the inline Bash blocks in the sections above (Boilerplate, Control Structures, Functions, Cleanup, Numeric Comparisons, Conditional Guards, Main Function, Output).
