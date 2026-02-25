---
name: bash-scripting
description: Write bash scripts following the user's preferred style conventions. Use when creating or editing bash/shell scripts (.sh files).
---

# Bash Scripting Style Guide

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

## Commands

- Use `$()` for command substitution, not backticks
- Chain commands with `||` for error handling: `cmd || fatal "msg"`
- Use long-form tar options: `-zxf`, `-ztf`

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
