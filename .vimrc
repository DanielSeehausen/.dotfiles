let $BASH_ENV = "~/.bash_aliases"

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/bundle')
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'morhetz/gruvbox' "colorscheme
Plugin 'dense-analysis/ale'
Plugin 'junegunn/fzf'
Plugin 'epmatsw/ag.vim'
Plugin 'janko-m/vim-test'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'mxw/vim-jsx'
Plugin 'ntpeters/vim-better-whitespace' "highlights trailing and between/pre tab whitespaces
Plugin 'nathanaelkane/vim-indent-guides' "gentle highlighting to view tab columns

" autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"appearance
set laststatus=2
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
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1

"cursor
set cursorline "highlights line cursor is on
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"ALE
let g:ale_sign_error = "❌"
let g:ale_sign_warning = "∙∙"
let g:ale_set_highlights = 0
let g:ale_lint_delay = 1000

"The Silver Searcher -- Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
"search from project root instead of cw
let g:ag_working_path_mode="r"
"bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"bind grep shortcut
nnoremap <C-\> :Ag<SPACE>

"fzf replacing ctrlp
set hidden "to ignore unsaved changes when switching
noremap <C-p> :FZF<CR>

"vim-test (this helps with some package.json resolution instead of looking in
"root, which is a problem with mono repos)
let g:root_markers = ['package.json', '.git/']
function! s:RunVimTest(cmd)
    " I guess this part could be replaced by projectionist#project_root
    for marker in g:root_markers
        let marker_file = findfile(marker, expand('%:p:h') . ';')
        if strlen(marker_file) > 0
            let g:test#project_root = fnamemodify(marker_file, ":p:h")
            break
        endif
        let marker_dir = finddir(marker, expand('%:p:h') . ';')
        if strlen(marker_dir) > 0
            let g:test#project_root = fnamemodify(marker_dir, ":p:h")
            break
        endif
    endfor

    execute a:cmd
endfunction

nnoremap <leader>T :w \| :call <SID>RunVimTest('TestFile')<cr>
nnoremap <leader>t :w \| :call <SID>RunVimTest('TestNearest')<cr>
nnoremap <leader>A :w \| :call <SID>RunVimTest('TestSuite')<cr>
nnoremap <leader>l :w \| :call <SID>RunVimTest('TestLast')<cr>

let test#javascript#jest#file_pattern = '\vtest?/.*\.(js|jsx|ts|tsx|coffee)$'
let test#javascript#jest#executable = 'npm run test'

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
"remove all trailing whitespace before :w events
autocmd BufWritePre * %s/\s\+$//e
"Save on exit insert mode and focus lost
autocmd InsertLeave * write
au FocusLost * :wa
"indent soft wraps visually
set breakindent
"Spellcheck
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
"same as vim jesus tpope's unimpaired plugin mappings. jump location list
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]l :lnext<CR>
"THIS ALSO AFFECTS AUTOCOMPLETION
set ignorecase
"auto reload files that have been changed
set autoread
"shortcut for search in visual selection. Just populates the \%V marker
vnoremap / <Esc>/\%V

"because mac has issues copying to clipboard...
nnoremap "+yy <S-v>:w !pbcopy<CR><CR>
"will copy all lines that are in the block...
vnoremap "+y :'<,'>w !pbcopy<CR><CR>

"temporary :p
nnoremap ;; :%s/;$//<CR>

"set undo directory (will persist undo history after buffers closed A+ :fire:)
set undofile
set undolevels=1000
set undodir=~/.vim/undo//

"hide my shame swap files
set directory=~/.vim/swap//

" ensures vimdiff wraps lines
au VimEnter * if &diff | execute 'windo set wrap' | endif

" set working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>
