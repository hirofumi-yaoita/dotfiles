if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ulwlu/elly.vim'

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
"Plug 'epii1/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'posva/vim-vue'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" php linter
"Plug 'w0rp/ale'
call plug#end()

" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'nanotech/jellybeans.vim'


syntax on
set ambiwidth=double
set list
set listchars=tab:>.,trail:_
set nu
set tabstop=4
set shiftwidth=4
set laststatus=2
set expandtab
set scrolloff=5
set incsearch
set nowrapscan
set smartindent
set ignorecase
set smartcase
set hid
set hlsearch
set backspace=indent,eol,start

" true color on tmux
" https://qiita.com/yami_beta/items/ef535d3458addd2e8fbb
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"colorscheme jellybeans
"colorscheme nord
colorscheme iceberg
"colorscheme atom-dark
"colorscheme elly

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

"nmap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite file_mru<CR>
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
nnoremap <SPACE>w 
nnoremap <SPACE>n :bn<CR>
nnoremap <SPACE>p :bp<CR>
nnoremap j gj
nnoremap k gk
nmap <C-]> <Plug>(coc-definition)

" for us-keyboard
"nnoremap ; :
"nnoremap : ;

set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=\ %l,%c%V%8P

hi ZenkakuSpace cterm=underline ctermfg=white ctermbg=blue
au BufRead,BufNew * match ZenkakuSpace /　/

let g:unite_enable_start_insert = 1
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction"}}}

autocmd FileType vue syntax sync fromstart
