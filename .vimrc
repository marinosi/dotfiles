" vimrc
" Main Author: Zaiste! <oh@zaiste.net>
" Contributed: Ilias Marinos
"

if $TERM == "xterm-256color" || $TERM == "screen-256color"
    set t_Co=256
endif
set nocompatible
set background=dark
set clipboard=unnamed
filetype on
"filetype off

" Utils {{{
source ~/.vim/functions/util.vim
" }}}

" Load external configuration before anything else {{{
if filereadable(expand("~/.vim/before.vimrc"))
  source ~/.vim/before.vimrc
endif
" }}}

let os = substitute(system('uname'), "\n", "", "")
let mapleader = ","
let maplocalleader = "\\"

" Local vimrc configuration {{{
let s:localrc = expand($HOME . '/.vim/local.vimrc')
if filereadable(s:localrc)
    exec ':so ' . s:localrc
endif
" }}}

" PACKAGE LIST {{{
" Use this variable inside your local configuration to declare
" which package you would like to include
if ! exists('g:vim_packages')
	let g:vim_packages = ['general', 'fancy', 'os', 'coding', 'indent', 'python', 'html', 'color']
endif
" }}}

" VUNDLE {{{
let s:bundle_path=$HOME."/.vim/bundle/"
execute "set rtp+=".s:bundle_path."vundle/"
call vundle#rc()

Bundle 'gmarik/vundle'
" }}}

" PACKAGES {{{

" _. General {{{
if count(g:vim_packages, 'general')
    Bundle 'editorconfig/editorconfig-vim'

    Bundle 'rking/ag.vim'
    nnoremap <leader>a :Ag -i<space>

    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-speeddating'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'tpope/vim-eunuch'
    "Bundle 'brookhong/cscope.vim'
    "nnoremap <leader>\ :call ToggleLocationList()<CR>

    Bundle 'scrooloose/nerdtree'
    nmap <C-i> :NERDTreeToggle<CR>
    " Disable the scrollbars (NERDTree)
    set guioptions-=r
    set guioptions-=L
    " Keep NERDTree window fixed between multiple toggles
    set winfixwidth

    Bundle 'vim-scripts/YankRing.vim'
    let g:yankring_replace_n_pkey = '<leader>['
    let g:yankring_replace_n_nkey = '<leader>]'
    let g:yankring_history_dir = '~/.vim/tmp/'
    nmap <leader>y :YRShow<cr>

    Bundle 'FelikZ/ctrlp-py-matcher'
    Bundle 'kien/ctrlp.vim'
    if has('python')
        let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    endif
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_working_path_mode = 'ra'
    if executable("ag")
        set grepprg=ag\ --nogroup\ --nocolor
        let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
              \ --ignore .git
              \ --ignore .svn
              \ --ignore .hg
              \ --ignore .DS_Store
              \ -g ""'
    endif
    let g:ctrlp_lazy_update = 350
    " Do not clear filenames cache, to improve CtrlP startup
    " You can manualy clear it by <F5>
    let g:ctrlp_clear_cache_on_exit = 0
    " Set no file limit, we are building a big project
    let g:ctrlp_max_files = 0
    "let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    " won't work if globpath() is not used (aka g:ctrlp_user_command is set)
    "set wildignore+=*/tmp/*,*.so,*.swp,*.zip
    "let g:ctrlp_custom_ignore = {
        "\ 'dir':  '\v[\/]\.(git|hg|svn)$',
        "\ 'file': '\v\.(exe|so|dll)$',
        "\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
        "\ }


    Bundle 'mtth/scratch.vim'

    Bundle 'troydm/easybuffer.vim'
    nmap <leader>be :EasyBufferToggle<enter>

    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'sjl/gundo.vim'
    nmap <leader>z :GundoToggle<CR>
endif
" }}}

" _. Fancy {{{
if count(g:vim_packages, 'fancy')
    call g:Check_defined('g:airline_left_sep', '')
    call g:Check_defined('g:airline_right_sep', '')
    "call g:Check_defined('g:airline_symbols.branch', '')
    Bundle 'bling/vim-airline'
    "let g:airline_symbols.branch = ''
    let g:airline_theme = 'dark'
    "let g:airline_theme = 'molokai'
    let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
    let g:airline#extensions#whitespace#mixed_indent_algo = 1
    let g:airline_powerline_fonts = 0
    let g:airline#extensions#tabline#enabled = 0
    "
    "Bundle 'itchyny/lightline.vim'
    "let g:lightline = {
      "\ 'colorscheme': 'wombat',
      "\ 'component': {
      "\   'readonly': '%{&readonly?"⭤":""}',
      "\ }
      "\ }
    "let g:lightline = {
          "\ 'colorscheme': 'wombat',
          "\ 'component': {
          "\   'readonly': '%{&readonly?"⭤":""}',
          "\ },
          "\ 'separator': { 'left': '⮀', 'right': '⮂' },
          "\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
          "\ }

    "Bundle 'edkolev/tmuxline.vim'
endif
" }}}

" _. Indent {{{
if count(g:vim_packages, 'indent')
  Bundle 'Yggdroot/indentLine'
  set list lcs=tab:\|\
  let g:indentLine_color_term = 111
  let g:indentLine_color_gui = '#DADADA'
  "let g:indentLine_char = 'c'
  "let g:indentLine_char = '∙▹¦'
  "let g:indentLine_char = '∙'
  let g:indentLine_char = '¦'
endif
" }}}

" _. OS {{{
if count(g:vim_packages, 'os')
    Bundle 'zaiste/tmux.vim'
    Bundle 'benmills/vimux'
    map <Leader>rp :VimuxPromptCommand<CR>
    map <Leader>rl :VimuxRunLastCommand<CR>

    map <LocalLeader>d :call VimuxRunCommand(@v, 0)<CR>
endif
" }}}

" _. Coding {{{
if count(g:vim_packages, 'coding')
    Bundle 'majutsushi/tagbar'
    nmap <leader>t :TagbarToggle<CR>

    Bundle 'gregsexton/gitv'

    Bundle 'scrooloose/nerdcommenter'
    nmap <leader># :call NERDComment(0, "invert")<cr>
    vmap <leader># :call NERDComment(0, "invert")<cr>

    Bundle 'tpope/vim-fugitive'
    nmap <leader>g :Ggrep
    " ,f for global git serach for word under the cursor (with highlight)
    nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
    " same in visual mode
    :vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

    Bundle 'airblade/vim-gitgutter'
    "Bundle 'mhinz/vim-signify'
    "
    "Bundle 'Valloric/YouCompleteMe'
    "let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    "let g:ycm_enable_diagnostic_signs = 0

    autocmd FileType gitcommit set tw=68 spell
    autocmd FileType gitcommit setlocal foldmethod=manual
endif
" }}}

" _. Python {{{
if count(g:vim_packages, 'python')
    Bundle 'klen/python-mode'
    Bundle 'python.vim'
    Bundle 'python_match.vim'
    "Bundle 'pythoncomplete'
endif
" }}}

" _. Golang {{{
    Bundle 'jnwhiteh/vim-golang'
" }}}


" _. HTML {{{
if count(g:vim_packages, 'html')
    Bundle 'tpope/vim-haml'
    Bundle 'tpope/vim-markdown'

    au BufNewFile,BufReadPost *.html setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
endif
" }}}

" _. Color {{{
if count(g:vim_packages, 'color')
    "Bundle 'sjl/badwolf'
    "Bundle 'altercation/vim-colors-solarized'
    "Bundle 'tomasr/molokai'
    "Bundle 'zaiste/Atom'
    "Bundle 'w0ng/vim-hybrid'
    "Bundle 'chriskempson/base16-vim'
    "Bundle 'Elive/vim-colorscheme-elive'
    "Bundle 'zeis/vim-kolor'
    "Bundle 'morhetz/gruvbox'
    Bundle 'flazz/vim-colorschemes'

    " During installation the badwolf colorscheme might not be avalable
	if filereadable(globpath(&rtp, 'colors/badwolf.vim'))
	  colorscheme badwolf
    "if filereadable(globpath(&rtp, 'colors/solarized.vim'))
      "colorscheme solarized
    else
      colorscheme default
    endif
else
    colorscheme default
endif
" }}}

" }}}

" General {{{
filetype plugin indent on

syntax on


" Set 5 lines to the cursor - when moving vertically
set scrolloff=0

" It defines where to look for the buffer user demanding (current window, all
" windows in other tabs, or nowhere, i.e. open file from scratch every time) and
" how to open the buffer (in the new split, tab, or in the current window).

" This orders Vim to open the buffer.
set switchbuf=useopen

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Mappings {{{

" Unmap arrow keys
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>

" Yank from current cursor position to end of line
map Y y$
" Yank content in OS's clipboard. `o` stands for "OS's Clipoard".
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" better ESC
inoremap <C-k> <Esc>

nmap <silent> <leader>hh :set invhlsearch<CR>
nmap <silent> <leader>ll :set invlist<CR>
nmap <silent> <leader>nn :set invnumber<CR>
nmap <silent> <leader>pp :set invpaste<CR>
nmap <silent> <leader>ii :set invrelativenumber<CR>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Source current line
vnoremap <leader>L y:execute @@<cr>
" Source visual selection
nnoremap <leader>L ^vg_y:execute @@<cr>

" Fast saving and closing current buffer without closing windows displaying the
" buffer
nmap <leader>wq :w!<cr>:Bclose<cr>

" }}}

" . abbrevs {{{
"
iabbrev i@ Ilias.Marinos@cl.cam.ac.uk

" . }}}

" Settings {{{
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set encoding=utf-8
set hidden
set history=1000
set incsearch
set laststatus=2
set list
set nofoldenable

" Don't redraw while executing macros
set nolazyredraw

" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" _ backups {{{
if has('persistent_undo')
  set undodir=~/.vim/tmp/undo//     " undo files
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
set noswapfile
" _ }}}

set modelines=0
set noeol
if exists('+relativenumber')
  set relativenumber
  set number
endif
set numberwidth=3
set winwidth=83
set ruler
if executable('zsh')
  set shell=zsh\ -l
endif
set showcmd

set exrc
set secure

set matchtime=2

set completeopt=longest,menuone,preview

" White characters {{{
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
"set expandtab
set noexpandtab
set wrap
set formatoptions=qrn1
if exists('+colorcolumn')
  set colorcolumn=+1
endif
" }}}

set visualbell

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu

set dictionary=/usr/share/dict/words
" }}}

" Triggers {{{

" Save when losing focus
au FocusLost    * :silent! wall
"
" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vimrc

" }}}

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
" }}}

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
" If you want to remove trailing spaces when you want, so not automatically,
" see
" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Display_or_remove_unwanted_whitespace_with_a_script.
autocmd BufWritePre * :%s/\s\+$//e

" }}}

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight word {{{

nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" }}}

" }}}

" Navigation & UI {{{

" Begining & End of line in Normal mode
noremap H ^
noremap L g_

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" }}}

" . folding {{{

set foldlevelstart=0
set foldmethod=syntax

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
"nnoremap <leader>z zMzvzz

" }}}

" Quick editing {{{

nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j:e ~/.vim/snippets/<cr>
nnoremap <leader>eg <C-w>s<C-w>j:e ~/.gitconfig<cr>
nnoremap <leader>ez <C-w>s<C-w>j:e ~/.zshrc<cr>
nnoremap <leader>et <C-w>s<C-w>j:e ~/.tmux.conf<cr>

" --------------------

set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

" showmarks
let g:showmarks_enable = 1
hi! link ShowMarksHLl LineNr
hi! link ShowMarksHLu LineNr
hi! link ShowMarksHLo LineNr
hi! link ShowMarksHLm LineNr

" }}}

" _ Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" EXTENSIONS {{{

" _. Scratch {{{
source ~/.vim/functions/scratch_toggle.vim
" }}}

" _. Tab {{{
source ~/.vim/functions/insert_tab_wrapper.vim
" }}}

" _. Text Folding {{{
source ~/.vim/functions/my_fold_text.vim
" }}}

" _. Text Folding {{{
source ~/.vim/functions/quickfix_toggle.vim
" }}}

" _. Gist {{{
" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
" }}}

" }}}

" TEXT OBJECTS {{{

" Shortcut for [] motion
onoremap ir i[
onoremap ar a[
vnoremap ir i[
vnoremap ar a[

" }}}

" Load addidional configuration (ie to overwrite shorcuts) {{{
if filereadable(expand("~/.vim/after.vimrc"))
  source ~/.vim/after.vimrc
endif
" }}}
