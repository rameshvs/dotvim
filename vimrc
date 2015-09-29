" This file is overly documented for convenience.

""" Misc setup before loading plugins
set nocompatible " don't care about vi
syntax enable
filetype plugin indent on


"""""""""""""""""""""""""""""
" Plugins and plugin config "
"""""""""""""""""""""""""""""

execute pathogen#infect()

""" Solarized (fonts/colors)
set t_Co=16
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

""" Syntastic
" pyflakes is fast and never complains about style
let g:syntastic_python_checkers = ['pyflakes']

""" CtrlP
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
nmap <c-b> :CtrlPBuffer<CR>

""" EasyMotion
" make easymotion use \f instead of \\f, etc
let g:EasyMotion_leader_key = '<Leader>'
" fix so that saving with '\w' doesn't override
let g:EasyMotion_mapping_w = '_w'

""" rainbow_parentheses
map <leader>p :RainbowParenthesesToggle<CR>

""" Arpeggio
call arpeggio#load()
Arpeggio inoremap jk <ESC>
Arpeggio inoremap fj <ESC>

""""""""""""""""""""""""
" Visual/display stuff "
""""""""""""""""""""""""

""" search-related stuff
set ignorecase
set smartcase
set incsearch
set hls
nmap <space><space> :noh<CR>/<BS>

" what to save between sessions:
" 100 files' marks, no files from temp media (OSX/ubuntu), no highlighting
set viminfo='100,r/Volumes/,r/media/,h

set wrap        " Wrap text in display instead of forcing scroll right
set showmatch   " show matching parens, brackets
set confirm     " Y-N-C prompt if closing with unsaved changes.
set ttyfast     " Fast terminal => better redrawing, etc
set vb t_vb=    " No visual bell
set nu          " show line numbers

""" status line
set showcmd      " show command as I'm typing it
set showmode     " Tell us what mode we're in (insert/replace/visual/etc)
set shortmess=a  " show short-format statuses for file info, etc
set report=0     " : commands always print changed line count.
set ruler        " Show current line/column info
set laststatus=2 " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]%r\ %f\ %h%w\ %y\ (%{&ff})\ 

if has("gui")
    set guioptions=acimgr
    " a: visual mode selections == system clipboard
    " c: console (not popup) dialogs
    " i: vim icon
    " mg: menu with unusable items grayed out
    " r: show scrollbar
    " F: footer?

    if has("gui_macvim")
       silent! set guifont=Inconsolata:h14
    endif

    if has("gui_gtk2")
       silent! set guifont=Inconsolata\ Medium\ 12
    endif

endif

""""""""""""""""""""""""""""""
" File/buffer handling stuff "
""""""""""""""""""""""""""""""

set autochdir  " change pwd to current file/buffer
set hidden     " hidden buffers
set splitright " new splits open to the right
set autoread   " auto-read changed buffers from disk
set encoding=utf8

cmap w!! w !sudo tee % > /dev/null " sets w!! to sudo write

" this should get best indenting for most common filetypes
filetype plugin indent on

""" Tab completion
set wildmode=longest,list:longest
" ignore some things when tab completing
set wildignore+=*.pyc                                      " python
set wildignore+=*.bbl,*.pdf,*.aux,*.blg,*.out,*.log,*.out  " latex
set wildignore+=*.class                                    " java
set wildignore+=*.DS_Store                                 " osx

set wildmenu

""" backup/swap/undo
" (double slash means editing /etc/X11/xorg.conf and ~/xorg.conf won't clobber)
set undolevels=10000 " Space is free
set backupdir=~/.vim/backup//
set backup
set directory=~/.vim/swap//
if v:version >= '703'
    set undodir=~/.vim/undo//
    set undofile
    set undoreload=10000
endif

"""""""""""""""""
" Editing stuff "
"""""""""""""""""
" search stuff
set ignorecase
set smartcase
set incsearch
" turn on hlsearch, but make it go away with <spc><spc>
set hls
nmap <space><space> :noh<CR>/<BS>


set history=10000 " Space is free: let's store all our history
set formatprg="par -w" " Use `par' for gq 

"""""""""""""""""""""""""""""""""""""""
" Interaction stuff / Useful commands "
"""""""""""""""""""""""""""""""""""""""

" thanks to http://superuser.com/q/401926
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

set timeoutlen=500
" all movements should move to the next line when at the end
set whichwrap=b,s,h,l,~,[,],<,>

set backspace=indent,eol,start " in insert mode, backspace can delete anything
set mouse= " don't use mouse
" set virtualedit=block,onemore " let cursor go one char past the end of a line
set virtualedit=block

if has("gui_running")
    highlight SpellBad term=underline gui=underline guisp='LightRed'
endif

""" how to do text formatting
" l=don't format for already-long-lines, c=auto-wrap comments, q=gq OK for comments
set formatoptions=lcq 

""" display » for wrapped lines,▸+<space> for tabs, › for trailing spaces
set list " show whitespace
set listchars=extends:»,tab:▸\ ,trail:› " which whitespace chars to show

" Use \w to save. conflicts w/EasyMotion default; hence the remap to '_w'
nnoremap <leader>w :w<CR>

" set completion to show a preview window
set cot=menu,preview,menuone " menu=menu,menuone=even if only 1 completion, preview=details

""" Language/filetype stuff
" so that .tex files are latex filetype
let g:tex_flavor='latex'

""""" Helpful commands

"" \r := save the current file, chmod it +x, and run it
noremap \r :w<CR>:!chmod u+x %<CR>:!./%<CR>
" yank to end of line
nmap Y y$
" move to wrapped areas w/j,k in normal/visual modes
" nnoremap j gj 
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk

set expandtab    " Tabs get inserted as spaces
set shiftwidth=4 " indentation size is 4 characters
set tabstop=4    " Tabs are displayed as 4 characters (not 8!)
set smarttab   " if on, uses shiftwidth @ line start, tabstop elsewhere
" shortcut for making it 8 (for compatibility): toggle tabstop
function! s:ToggleTabSize()
    if tabstop==4
        tabstop=8
    elseif tabstop == 8
        tabstop=4
    endif
endfunc
nnoremap <C-Tab> :call s:ToggleTabSize()

""" typo correction
abbreviate teh the
abbreviate ot to

" Bubble single lines with control-arrows
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines up/down in visual mode
vmap <C-Up> [egv
vmap <C-Down> ]egv
" Indent/dedent multiple lines in visual mode
vnoremap <C-Right> >gv
vnoremap <C-Left> <gv

"""""""""""""""""""""
" Autocommand stuff "
"""""""""""""""""""""
if has("autocmd")
    " commentstring: used for folding and for vim-commentary
    autocmd FileType latex set commentstring=%\ %s
    autocmd FileType tex set commentstring=%\ %s
    autocmd FileType python set commentstring=#\ %s
    autocmd FileType matlab set commentstring=\%\ %s
    " adds execute permissions if file starts with appropriate shebang
    augroup executePermissions
        au!
        autocmd BufWritePost * call NoExtNewFile()
        function! NoExtNewFile()
            if getline(1) =~ "^#!.*/bin/"
                if &filetype == ""
                    filetype detect
                endif
                silent !chmod a+x <afile>
            endif
        endfunction
    augroup END

    " TODO assign a hotkey to "close tag", whether it's HTML tags,
    " latex blocks, etc
    " Automatically close HTML tags
    augroup htmlTags
        au!
        autocmd FileType html let b:closetag_html_style=1
        autocmd FileType html source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
    augroup End
    " TODO automatically close latex \begin \end blocks

    augroup vimStuff
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    " Always re-source vimrc after saving it
        autocmd bufwritepost .vimrc source $MYVIMRC
    augroup END

endif
set autoindent
" Don't automatically un-indent when entering a #
" inoremap # X#

"""""""""""""""""""""""""""""""
" potentially useful snippets "
"""""""""""""""""""""""""""""""

" map <buffer> <leader>m :w<CR>:!make<CR> " run make

" difference between the current buffer and the file it was loaded from, 
" (i.e., changes you made)
" command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | set fdl=99 | wincmd p | diffthis | set fdl=99

""" fold stuff
" set fdo=hor,insert,search,undo,tag " what expands? hor=jl, others self-expl.
" set fdm=marker
" set foldlevelstart=0

" Bindings for tabbed editing
" noremap <C-n> :tabnew<CR>
" noremap <C-l> :tabnext<CR>
" noremap <C-h> :tabNext<CR>

" set grepprg="ack"

""" Tags
"" open defn in new tab
" map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"" open defn in new vsplit
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" set tags=./.tags,./tags,tags

" map tag commands to be nicer
" nmap <C-Right> <C-]>
" nmap <C-Left> <C-T>
