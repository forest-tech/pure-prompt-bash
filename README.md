# pure-prompt-bash

Pure-style prompt for Bash.

Inspired by [Pure](https://github.com/sindresorhus/pure) and [pure-bash](https://github.com/nojhan/pure-bash).

This prompt keeps the minimal look of Pure while adding a simple SSH-aware host indicator for Bash environments.

## Usage

1. Place the prompt script here:

   ```bash
   ~/.config/bash/pure.bash
   ```

2. Write in `~/.bashrc`:

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

## Credits

Inspired by:

* [Pure](https://github.com/sindresorhus/pure)
* [pure-bash](https://github.com/nojhan/pure-bash)

The prompt design and Git status conventions are based on Pure, with additional SSH host display behavior for Bash environments.
