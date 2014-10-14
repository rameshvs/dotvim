.vim
---
This is my vim configuration. To use this, you'll need to clone it into some
folder (I use `~/.vim`, but you can use `~/.vim.d` or whatever you prefer) and
then link `~/.vimrc` to this folder's vimrc:

    git clone --recursive http://github.com/rameshvs/dotvim $HOME/.vim
    ln -s $HOME/.vim/vimrc .vimrc

I've tested this on Mac OS X 10.8 and a few flavors of linux. I can't make
any guarantees, but I do try to make sure it works across all platforms
that I use.

Many of the settings in `vimrc` are well-documented, and vim's excellent
`:help` should fill in the gaps.

Plugins
---
I organize my plugins using git submodules and [pathogen](http://github.com/tpope/vim-pathogen).

To add a plugin conveniently from the command line, you could define the
following function at the command prompt:

    $ addrepo() { git submodule add https://github.com/$1 "bundle/$(echo $1 | cut -d "/" -f 2)"; };

Once you've done that, you can run `addrepo <github user>/<github project>`
to add the corresponding git repository.

For example, to add the plugin vim-commentary from
`https://github.com/tpope/vim-commentary`, use the following command from the
command prompt:

    $ addrepo tpope/vim-commentary

Here are all the plugins included here:

* [vim-commentary](http://github.com/tpope/vim-commentary): makes it easier to comment stuff out
* [vim-repeat](http://github.com/tpope/vim-repeat): enables repeating of plugin commands
* [vim-surround](http://github.com/tpope/vim-surround): enables selection within parens, etc
* [vim-markdown](http://github.com/tpope/vim-markdown): syntax highlighting for markdown
* [solarized](http://github.com/altercation/vim-colors-solarized): the best color scheme
* [rainbow_parentheses](http://github.com/kien/rainbow_parentheses.vim): highlight parens with many colors
* [vim-arpeggio](http://github.com/kana/vim-arpeggio): arbitrary pairs of keys can be commands
* [ctrlp](http://github.com/kien/ctrlp.vim): the best way to manage & find files/buffers
* [vim-easymotion](http://github.com/Lokaltog/vim-easymotion): use `<leader>+<movement>` to move around much faster
* [syntastic](http://github.com/scrooloose/syntastic): linting/error checking
* [bufkill](http://github.com/vim-scripts/bufkill.vim): enables ":BD" to remove a buffer without closing the window (i.e., mimicking emacs's C-x k)
* [rename](http://github.com/vim-scripts/Rename): use ":rename" to rename

