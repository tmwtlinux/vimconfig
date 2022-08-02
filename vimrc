set nocompatible
set exrc
set nobackup
set expandtab
set fileformat=unix
set autoindent
set laststatus=2
set statusline=%F%m\ line\ %l\/%L%=col\ %c\ (%b)\ %v\ %y
set wildmenu
set undofile
set undodir=~/.vim/undodir
set path+=**
set runtimepath=~/.vimplugins,$VIMRUNTIME,~/.vim
set mouse=c
set hidden
set tabpagemax=100
set fsync
set pastetoggle=<F2>
set keywordprg=man
set tabstop=2
set softtabstop=2
set shiftwidth=2 
set timeoutlen=500

colorscheme darkblue
if has('syntax')
  syntax on
endif

let g:netrw_altv=1
let g:netrw_winsize=40
let g:netrw_banner=0

let g:default_comment = '#'
let g:initial_branch='main'
let g:noconfirm=1

let mapleader = ',' " set leader to ,

function CommentLineOut ()
  let curr_line = getline('.')
  let file_type = expand('%:e')
  let file = expand('%:t')

  if file == '.vimrc'
    if curr_line[0] == '"'
      :execute "normal 0xj0"
    else 
      :execute "normal 0i\"\<esc>j0"
    endif
  elseif file_type == 'cpp' || file_type == 'hpp'
    if curr_line[0] == '/' && curr_line[1] == '/'
      :execute "normal 02xj0"
    else
      :execute "normal 0i//\<esc>j0"
    endif
  elseif file_type == 'c' || file_type == 'h'
    let line_len = len(curr_line) 
    if curr_line[0] == '/' && curr_line[1] == '*' && curr_line[line_len-2] == '*'  && curr_line[line_len-1] == '/' 
      execute "normal 02x$xxj0"
    else
      execute "normal 0i/*\<esc>A*/\<esc>j0"
    endif
  else
    if curr_line[0] == g:default_comment
      :execute "normal 0xj0"
    else 
      :execute "normal 0i".g:default_comment."\<esc>j0"
    endif
  endif
endfunction

" to create an html basic structure 
function HTML_basic_structure ()
  :call setline(1, "<!DOCTYPE html>")
  :call setline(2, "<html lang=\"de\">")
  :call setline(3, "<head>")
  :call setline(4, "\t<meta charset=\"UTF-8\">")
  :call setline(5, "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">")
  :call setline(6, "\t<title>Document</title>")
  :call setline(7, "</head>")
  :call setline(8, "<body>")
  :call setline(9, "<h1 id=\"greeting\"> Hello, World </h1>")
  :call setline(10, "</body>")
  :call setline(11, "</html>")
endfunction

function CreateGitRepo(path)
  let initial_branch = input('Enter initial branch name: ')
  execute "!clear && git init --initial-branch=".g:initial_branch." --quiet ".a:path
endfunction

function GitCommit ()
  let added_files = input('Enter files to commit: ')
  let commit_messages = input('Enter Commit message: ')
  exec ":wa" 
  " save files before we commit and push
  exec "!git add -- ".added_files." && git commit -m \"".commit_messages."\""
  exec "!git push"
endfunction

augroup scripts
  autocmd BufNewFile  *.sh call setline('.', '#!/bin/bash') | source ~/.vim/bash/bash.vim
  autocmd BufRead     *.sh source ~/.vim/bash/bash.vim

  autocmd BufNewFile  *.py call setline(1, '#!/usr/bin/python') | source ~/.vim/python/python.vim
  autocmd BufRead     *.py source ~/.vim/python/python.vim

  autocmd BufNewFile  *.rb call setline(1, '#!/usr/bin/ruby') | source ~/.vim/ruby/ruby.vim
  autocmd BufRead     *.rb source ~/.vim/ruby/ruby.vim

  autocmd BufNewFile  *.html call HTML_basic_structure()
augroup END

map <leader>e :call OpenBrowser()<CR>
map <leader>t :tabe .gitignore<CR>
map <leader>n :set nu!<CR>
map <leader>q :call CreateGitRepo('.')<return>
map <F2> :call GitCommit()<return>
map <F3> :call CommentLineOut()<return>

:command Reload :source ~/.vimrc
:command Vimrc :tabedit ~/.vimrc
:command Shell w!|sh
