# pure-prompt-bash

Pure-style prompt for Bash.

Inspired by [Pure](https://github.com/sindresorhus/pure) and [pure-bash](https://github.com/nojhan/pure-bash).

This prompt keeps the minimal look of Pure while adding a simple SSH-aware host indicator for Bash environments.

## Usage

1. Place the prompt script here:

   ```bash
   ~/.config/bash/pure.bash
   ```

2. Source it from `~/.bashrc`:

   ```bash
   source ~/.config/bash/pure.bash
   ```

3. Reload your shell:

   ```bash
   source ~/.bashrc
   ```

## Appearance

Local shell:

```text
~/projects/example-repo main*
❯
```

SSH session:

```text
(remote-host) ~/projects/example-repo main* ⇣
❯
```

## Features

* Pure-style two-line prompt
* Shows the current directory
* Shows the current Git branch
* Shows `*` when the working tree is dirty
* Shows Git upstream status

  * `⇣` when the local branch is behind
  * `⇡` when the local branch is ahead
  * `⇣⇡` when both are true
* Shows `(hostname)` only when connected over SSH
* Changes the prompt symbol color based on the previous command result

  * magenta on success
  * red on failure
* Uses ANSI colors directly

## Git status

The prompt compares the current branch with its configured upstream branch.

```text
main
```

The local branch is up to date.

```text
main ⇣
```

The local branch is behind its upstream branch.

```text
main ⇡
```

The local branch is ahead of its upstream branch.

```text
main ⇣⇡
```

The local and upstream branches have diverged.

A dirty working tree is indicated with `*`:

```text
main*
```

For example:

```text
main* ⇣
```

means that the working tree contains local changes and the local branch is behind its upstream branch.

Note that the prompt does not automatically run `git fetch`, so the upstream status reflects the latest remote state known by the local Git repository.

## SSH

When running inside an SSH session, the hostname is added before the current directory:

```text
(remote-host) ~/projects/example-repo main
❯
```

When running locally, the hostname is omitted:

```text
~/projects/example-repo main
❯
```

## Credits

Inspired by:

* [Pure](https://github.com/sindresorhus/pure)
* [pure-bash](https://github.com/nojhan/pure-bash)

The prompt design and Git status conventions are based on Pure, with additional SSH host display behavior for Bash environments.
