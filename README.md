# Usage

## .vimrc configuration

To use the provided `.vimrc` do the following:

1. Install the required dependencies:
    * On Arch Linux: `sudo pacman -S --needed vim git curl ctags the_silver_searcher`
    * On Ubuntu: `sudo apt-get install vim git curl universal-ctags silversearcher-ag`
    * On Rocky Linux: `sudo yum install epel-release; sudo yum install vim git ctags the_silver_searcher`
1. Get the provided `.vimrc` **(this will overwrite your existing `~/.vimrc`!)**:
    ```bash
    curl -Lfo ~/.vimrc 'https://raw.githubusercontent.com/blochl/dotfiles/main/.vimrc'
    ```
1. Download the vim-plug plugin manager:
    ```bash
    curl -Lfo ~/.vim/autoload/plug.vim --create-dirs \
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```
1. Install the plugins (this can take a few minutes):
    ```bash
    vim -Esu ~/.vimrc +'PlugInstall --sync' +qa
    ```
1. On your _local_ machine, install the [DejaVu Sans Mono for Powerline fonts](https://github.com/powerline/fonts/tree/master/DejaVuSansMono), and set them as the font of your _local_ terminal, to get the special symbols on the footer line.
1. Enjoy your awesome Vim!
    * Try the new shortcuts:
        * `\s` - smart spellcheck
        * F12 - next buffer, F11 - prev. buffer, F5 - list buffers
        * `\t` - toggle NERDTree
        * `\b` - toggle Tagbar
        * `\f` when standing on a word - look for all instances in the codebase (unlike the usual "Ctrl + ]" to jump to definition).
        * And more...

## tmux configuration

The tmux configuration provided here allows mouse navigation between panes, and
mouse scrolling (at a price of copy-pasting only while the shift key is
pressed). It also activates the Vi mode, and fixes color display in terminals
where `TERM` is not set to `xterm`/`xterm-256color` (_e.g._: rxvt-unicode).

It only fits tmux versions above and including 2.1. On older versions you'll
get errors like:

```
ambiguous option: mouse
```

If you absolutely must use an older version, you can replace the
`set -g mouse on` line with the following lines:

```
set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
```

For user-wide effect, do **(WARNING: this will overwrite your existing config, if any)**:

```bash
curl -Lfo ~/.tmux.conf 'https://raw.githubusercontent.com/blochl/dotfiles/main/.tmux.conf'
```

For global effect, do **(WARNING: this will overwrite your existing config, if any)**:

```bash
sudo curl -Lfo /etc/tmux.conf 'https://raw.githubusercontent.com/blochl/dotfiles/main/.tmux.conf'
```
