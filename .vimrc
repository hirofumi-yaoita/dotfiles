if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'posva/vim-vue'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'kristijanhusak/defx-icons'
Plug 'ryanoasis/vim-devicons'

" colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ulwlu/elly.vim'

" php linter
"Plug 'w0rp/ale'
call plug#end()

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
colorscheme nord
"colorscheme iceberg
"colorscheme atom-dark
"colorscheme elly

hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE ctermfg=241 guibg=NONE guifg=NONE
hi SpecialKey ctermbg=NONE ctermfg=241 guibg=NONE guifg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi Folded ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE


"nmap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <silent> ,d :<C-u>Defx<CR>
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
nnoremap ; :
nnoremap : ;

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

let g:ctrlp_custom_ignore = '\v(vendor/|node_modules/)'

call defx#custom#option('_', {
  \ 'winwidth': 40,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': 'exlorer',
  \ 'toggle': 0,
  \ 'resume': 1,
  \ 'columns': 'indent:icons:filename:mark',
  \ })

autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()

autocmd FileType defx call s:defx_my_settings()
autocmd FileType defx set nonu

function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
