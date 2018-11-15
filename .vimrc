set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" on first run clone vundle how it says in its README and :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'elixir-lang/vim-elixir'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'kien/ctrlp.vim'
"Plugin 'nanotech/jellybeans.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/fzf'
Plugin 'itchyny/lightline.vim'
"Plugin 'roman/golden-ratio'
Plugin 'epmatsw/ag.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"appearance
colorscheme gruvbox 
set background=dark
syntax on
set hlsearch

"line numbers
set nu

"tabbing
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set shell=bash

"backspace key
set backspace=2

":e autocomplete settings
set wildmenu
set wildmode=longest:list,full

"format the statusline

"NERDTREE
map <C-n> :NERDTreeToggle<CR>
map <C-j> :!python -m json.tool<CR>
let NERDTreeShowHidden=1

"file tree
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction
set tags=tags

"cursor
set cursorline
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"Symbols
let g:syntastic_error_symbol = "❌"
let g:syntastic_warning_symbol = "∙∙"
let g:syntastic_style_error_symbol = '∙∙'
"hi behind the symbols
hi SyntasticErrorSign ctermfg=243 ctermbg=236 guifg=#777777 guibg=darkgrey
"in text error highlighting -- [SyntasticError SyntasticWarning SyntasticErrorSymbol SyntasticErrorLine]
"hi SyntasticErrorLine ctermfg=013 ctermbg=013 guifg=#0000ff guibg=#0000ff
"hi SyntasticErrorSymbol ctermfg=013 ctermbg=013 guifg=#0000ff guibg=#0000ff
"JS
let g:syntastic_javascript_checkers = ['eslint']

"fzf
map ; :FZF<CR>

"lightline
set laststatus=2

" The Silver Searcher -- Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" search from project root instead of cw
let g:ag_working_path_mode="r"
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

"general editor 
set timeoutlen=1000 ttimeoutlen=0
set guifont=Menlo\ Mono:h14
"some buffer swapping QoL (probably should remove this -- ctrl ] needed)
nnoremap <C-]> :bn<CR>
"needed so that vim still understands escape sequences (otherwise scrolling will go into insert mode, it will open with fzf lookup window, etc.)
nnoremap <esc>^[ <esc>^[
"indent line breaks
set breakindent
