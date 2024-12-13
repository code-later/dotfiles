# Dotfiles

This repository contains my opinionated collection of dotfiles. It mainly
consists of zsh and Vim configuration. Feel free to use it or take any
ideas from it.

**Disclaimer:** My main work environment is Mac OS X. I use [iTerm2][1] as
terminal with 256 colors. Generally I work with a very small font. I use
these dotfile on Ubuntu servers too, but not on a daily basis. I will
not gurantee that it will work on other environments and not even on
this all the time ;-) Be sure to check any changes before just getting
the latest version.

## Installation

As already mentioned my shell is zsh. Be sure to change yours before
using my config. If you don't like zsh you could just use the Vim stuff.
Changing the shell on OS X can be done via the Account Preference Pane.
Alternatively you can switch it via this command:

    chsh -s /bin/zsh

To make Vim work as expected you need Vim compiled with Ruby support and
the `--with-features=HUGE` flag. After that, clone the repository and
run the included install script:

    git clone git://github.com/railsbros-dirk/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install

After that everything should be setup correctly and you can start to use
zsh and Vim.

### Partial Installation

If you just want to install the Vim setup or Zsh configs you can run the
install script with a additional parameter. For instance the following
will only install the Vim configuration.

    ./install vim

For a complete list of available options run:

    ./install help

**NOTE:** The script will _not_ overwrite existing configuration. If you
want to use the script move your "old" files out of the way first ;-)

## Features

I understand that some information is not very well stored in the
repository and should be configurable on each machine. Due to this you
have some points where you can provide your own config:

  * `~/.vimrc.local` -> Provide custom Vim configuration. Will be loaded
  after `~/.vimrc`
  * `.zsh_config_for_USERNAME` -> Provide custom zsh configuration
  * `.gitconfig` -> The install script will just generate it. You
  have/can provide additional information any time.

### Projects Dir

Pointing the variable `projects_dir` to something useful for you will
enable you to use the shortcut `p PROJECT_NAME`. This will bring you
directly to the given directory under the configured `projects_dir` path:

    projects_dir="$HOME/Documents/projects"
    $ p my_project

This will change into the directory `$HOME/Documents/projects/my_project`.

### Vundle

I used to manage my Vim plugins with Tim Popes great [pathogen plugin][2].
Recently I discovered [Vundle][3] by [gmarik][4] and it is just awesome.
You only have to manage the vundle via git submodule by yourself and all
other plugins are managed by Vundle.

### Color Scheme

My color scheme for Vim is a slightly modified version of Chris Kempsons
[Tomorrow Night Bright][5]. I suggest to use the same for your terminal
to get the best color experience in Vim and zsh.

### Fuzzy Finder in Vim

Currently the fuzzy finder plugin of choice is [ctrlp][6]. You can fire
it up by hitting `Ctrl-p` (what a suprise). Take a look in the docs to
find out more about it.

There is a bunch of other stuff I use. Describing it all would take too
much time. Just look through the single config files to get an idea what
is possible. I don't use something like [oh-my-zsh][7] or [Janus][8] to
keep it more obvious what is going on.

Feel free to use whatever you want for your own dotfiles. If you use
mine I hope they taking you somewhere.

## KeyRemap4MacBook

For my keyboard configuration I use [KeyRemap4MacBook][18] and [PCKeyboardHack][19]. Both
tools are really great and help me to make some fancy stuff like using the
Caps-Lock key as both Control AND Escape :stuck_out_tongue_winking_eye: Besides
that I use it to emulate some missing keys on my mini keyboard which misses the
F-layer. If you want to use the KeyRemap4MacBook config make sure to add the
following to the `private.xml`:

```xml
<?xml version="1.0"?>
<root>
  <include path="{{ ENV_HOME }}/.dotfiles/key_remap_config.xml" />
</root>
```

## Thanks

I didn't came up will all that configuration by myself. Here is a list
of people I took inspiration from or just copied some code ;-)

  * Todd Werth - My dotfiles were originally a fork of [his][9]
  * Gary Bernhardt - Inspired by both the [Peepcode Play by Play episode][11]
  and his own screencasts ['Destroy all Software'][12]
  * [Both][13] [Vim][14] screencasts by Peepcode
  * [tisba][17], [Marc Kalmes][15] and [Michael Contento][16]

[1]: http://www.iterm2.com/
[2]: https://github.com/tpope/vim-pathogen
[3]: https://github.com/gmarik/vundle
[4]: http://gmarik.info/about
[5]: https://github.com/chriskempson/tomorrow-theme
[6]: https://github.com/kien/ctrlp.vim
[7]: https://github.com/robbyrussell/oh-my-zsh
[8]: https://github.com/carlhuda/janus
[9]: https://github.com/twerth
[10]: https://github.com/garybernhardt/dotfiles
[11]: https://peepcode.com/products/play-by-play-bernhardt
[12]: https://www.destroyallsoftware.com/screencasts
[13]: https://peepcode.com/products/smash-into-vim-i
[14]: https://peepcode.com/products/smash-into-vim-ii
[15]: https://github.com/mkalmes/dotfiles
[16]: https://github.com/michaelcontento/dotfiles
[17]: http://tisba.de/
[18]: https://pqrs.org/macosx/keyremap4macbook/index.html.en
[19]: https://pqrs.org/macosx/keyremap4macbook/pckeyboardhack.html.en
