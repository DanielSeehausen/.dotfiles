set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" on first run clone vundle how it says in its README and :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'morhetz/gruvbox' "colorscheme
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/fzf'
Plugin 'epmatsw/ag.vim'
Plugin 'janko-m/vim-test'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ntpeters/vim-better-whitespace' "highlights trailing and between/pre tab whitespaces
Plugin 'nathanaelkane/vim-indent-guides' "gentle highlighting to view tab columns

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"appearance
colorscheme gruvbox
set guifont=Menlo\ Mono:h14
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

"NERDTREE
map <C-n> :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>
nmap <Leader>r :NERDTreeRefreshRoot
let NERDTreeShowHidden=1

"cursor
set cursorline "highlights line cursor is on
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
let g:syntastic_style_error_symbol = '∙'
"hi behind the symbols
hi SyntasticErrorSign ctermfg=243 ctermbg=236 guifg=#777777 guibg=darkgrey
"JS
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

"The Silver Searcher -- Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
"search from project root instead of cw
let g:ag_working_path_mode="r"
"bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"bind grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <C-\> :Ag<SPACE>

"fzf replacing ctrlp
noremap <C-p> :FZF<CR>

"vim-test
let test#javascript#jest#file_pattern = '\vtest?/.*\.(js|jsx|coffee)$'
let test#javascript#jest#executable = 'npm run test'
nnoremap <Leader>t :w<CR>:TestNearest<CR>
nnoremap <Leader>T :w<CR>:TestFile<CR>
nnoremap <Leader>l :w<CR>:TestLast<CR>
nnoremap <Leader>A :w<CR>:!npm run test<CR>

"ntpeters/vim-better-whitespace highlights trailing whitespaces and
"whitespaces between/preceeding tabs
hi ExtraWhitespace ctermbg=darkgrey
let g:show_spaces_that_precede_tabs=1

"nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1 "indent guides enabled by def
hi IndentGuidesOdd  ctermbg=236
hi IndentGuidesEven ctermbg=235

" *** general editor ***
set timeoutlen=750 ttimeoutlen=0
"The length of time Vim waits before triggering the plugins
set updatetime=100
"needed so that vim still understands escape sequences (otherwise scrolling will go into insert mode, it will open with fzf lookup window, etc.)
nnoremap <esc>^[ <esc>^[
"Every time the user issues a :w command, Vim will automatically remove all trailing whitespace before saving
autocmd BufWritePre * %s/\s\+$//e
"Save on exit insert mode and focus lost
autocmd InsertLeave * write
:au FocusLost * :wa
"indent soft wraps visually
set breakindent
"Spellcheck
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
"same as vim jesus tpope's unimpaired plugin mappings. newline above/below cursor without entering insert mode
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>
"THIS ALSO AFFECTS AUTOCOMPLETION
set ignorecase
"auto reload files that have been changed
set autoread




"temporary :p
nnoremap ;; :%s/;$//<CR>
