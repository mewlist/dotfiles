set tabstop=1
set shiftwidth=2
set expandtab
set autoindent
set nocompatible
set backspace=2
set wildmenu
set laststatus=1
set showcmd
set hlsearch
set incsearch
syntax on
filetype on
filetype indent on
filetype plugin on
colorscheme default
setlocal omnifunc=syntaxcomplete#Complete
imap <Nul> <c-x><c-o>
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y]\ [%04l,%04v][%p%%]

set lcs=tab:>.,trail:_,extends:\
set list
highlight SpecialKey cterm=NONE ctermfg=7 guifg=#AA0000
highlight JpSpace cterm=underline ctermfg=8 guifg=#AA0000
highlight Space cterm=reverse ctermfg=1 guifg=#AA0000
au BufRead,BufNew * match JpSpace /　/
au BufRead,BufNew * match Space /\s\+$/

nmap ,a :!alert rspec -b --drb %
nmap ,s :!alert-sticky rspec -b --drb %
nmap ,r :call RSpecLine() <CR>
nmap ,j :'<,'> call TrJA() <CR>
nmap ,e :'<,'> call TrEN() <CR>
vmap ,j : call TrJA()  <CR>
vmap ,e :jcall TrEN()  <CR>
nmap ,l :redraw! <CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-TAB> <C-W>w

set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set backupdir=/tmp
function TrEN() range
  silent execute "normal! gv:B s/.\\+/\\=system('echo -n '.submatch(0).' | translate e')/g\<CR>"
endfunction
function TrJA() range
  silent execute "normal! gv:B s/.\\+/\\=system('echo -n '.submatch(0).' | translate j')/g\<CR>"
endfunction

au BufRead,BufNewFile *.slim set filetype=slim

" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt

"" Vundle '''
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

call pathogen#infect()

let plugin_dicwin_disable = 1
Bundle 'gmarik/vundle'

" 利用中のプラグインをBundle
Bundle 'vim-scripts/AutoComplPop'
Bundle 'vim-scripts/TabBar'
Bundle 'taku-o/vim-vis'
Bundle 'scrooloose/nerdtree'
Bundle 'bbommarito/vim-slim'
Bundle 'msanders/snipmate.vim'
Bundle 'mattn/zencoding-vim'
Bundle 'VimExplorer'
Bundle 'tsaleh/vim-align'
Bundle 'Shougo/unite.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "snipmate-snippets"
Bundle "garbas/vim-snipmate"
Bundle "skwp/vim-rspec"
Bundle "Shougo/vimfiler"


if has('mac') && !has('gui')
    nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
    vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
    nnoremap <silent> <Space>p :r !pbpaste<CR>
    vnoremap <silent> <Space>p :r !pbpaste<CR>
" GVim(Mac & Win)
else
    noremap <Space>y "+y
    noremap <Space>p "+p
endif

" vim-rspec
function RSpecLine()
  execute '! zsh -c ". $rvm_path/scripts/rvm; rspec -O ~/.rspec -X % -l '.line('.').'"'
endfunction

