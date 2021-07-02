" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugin')
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent off


syntax on
set number
set autoindent
set smartindent
set noexpandtab
set tabstop=8
set shiftwidth=8
set wildmenu
set hlsearch
set background=dark
set t_Co=256
set completeopt=menuone,preview,noselect

"Useful abbreviations
map j gj
map k gk
map 0 g^
map $ g$
map d) d])
map c) c])
map K kJ

" Insert shortcuts
"imap <C-p> #include <stdio.h><CR>#include <stdlib.h><CR>
imap <C-e> <CR>\begin{equation}<CR>\end{equation}<ESC>O
imap <C-u> \sum_{i=1}^n
" imap { {<CR>f<CR><BS>}<ESC>kla<BS>

" Split settings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-R> <C-W><C-R>
set splitbelow
set splitright

" Customized jumping between marks
map '' '"
map `` `"

" Switch 2 pieces of code
vmap s "0c#1#<ESC>
vmap x d"0P/#1#<CR>:%s//\=@"/g<CR>

"Folding
set foldmethod=manual
set foldlevel=99
"Comment out and back in (including augroups and useful mappings)
function CommentOut(comment_chars)
	s/^/\=a:comment_chars/
endfunction
function CommentIn(comment_chars)
	execute 'substitute/' . escape(a:comment_chars, '/') . '//'
endfunction
command -range CO :<line1>,<line2>call CommentOut('#')
command -range CI :<line1>,<line2>call CommentIn('#')
augroup java_settings
	autocmd!
	autocmd BufNewFile,BufRead *.java command! -range CO :<line1>,<line2>call CommentOut('//')
	autocmd BufNewFile,BufRead *.java command! -range CI :<line1>,<line2>call CommentIn('//')
augroup END
augroup latex_settings
	autocmd!
	autocmd BufNewFile,BufRead *.java command! -range CO :<line1>,<line2>call CommentOut('%')
	autocmd BufNewFile,BufRead *.java command! -range CI :<line1>,<line2>call CommentIn('%')
augroup END
augroup R_settings
	autocmd!
	autocmd BufNewFile,BufRead *.{R,r} command! R :!reinstall
augroup END
map ö :CO<CR>
map ä :CI<CR>

"Moving in command mode
cmap <ESC>[1;2D <C-Left>
cmap <ESC>[1;2C <C-Right>
function BadIndentation()
	set expandtab
	set softtabstop=4
	set shiftwidth=4
endfunction
command BI :call BadIndentation()
"set spell
"set spelllang=en_us

" This is important in order to use Vim as a man-page viewer
let $PAGER=''
source /usr/share/vim/vim82/ftplugin/man.vim
