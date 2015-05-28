set tabstop=4
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
syntax enable
filetype on
filetype indent on
filetype plugin on
colorscheme default
setlocal omnifunc=syntaxcomplete#Complete
imap <Nul> <c-x><c-o>
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y]\ [%04l,%04v][%p%%]

hi Pmenu ctermbg=7
hi PmenuSel ctermbg=4
hi PmenuSbar ctermbg=0
hi PmenuThumb ctermfg=7

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
nmap gl :call GitLog() <CR>
nmap gb :call GitBlame() <CR>
nmap ,R :call RSpecAll() <CR>
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
nnoremap <silent> ,ua :<C-u>Unite -buffer-name=files buffer file_rec bookmark file<CR>
nnoremap <silent> <Nul> :<C-u>Unite -buffer-name=files buffer file_rec<CR>

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

set tags=./tags
set tags+=~/.tags/**;

" -------------------------------
" NeoBundle
" -------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" コード補完
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'

" 静的解析
NeoBundle 'scrooloose/syntastic'

" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

" メソッド定義元へのジャンプ
NeoBundle 'szw/vim-tags'

" 自動で閉じる
NeoBundle 'tpope/vim-endwise'

" 利用中のプラグインをBundle
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle "snipmate-snippets"

NeoBundle 'taku-o/vim-vis'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'tsaleh/vim-align'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-pathogen'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-rails'
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle "skwp/vim-rspec"

call neobundle#end()

NeoBundleCheck

" -------------------------------
" Rsense
" -------------------------------
let g:rsenseHome = '/usr/local/Cellar/rsense/0.3/libexec'
let g:rsenseUseOmniFunc = 1

" --------------------------------
" neocomplete.vim
" --------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

" --------------------------------
" rubocop
" --------------------------------
" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" --------------------------------
" 基本設定
" --------------------------------
" 想定される改行コードの指定する
set fileformats=unix,dos,mac

call pathogen#infect()

let g:unite_enable_start_insert = 1
let g:Align_xstrlen = 3

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

function RSpecAll()
  execute '! zsh -c ". $rvm_path/scripts/rvm; rspec -O ~/.rspec -X %"'
endfunction
" git blame
function GitBlame()
  execute '! zsh -c "git blame -w %"'
endfunction
function GitLog()
  execute '! zsh -c "git log %"'
endfunction


imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

set backupskip=/tmp/*,/private/tmp/*
