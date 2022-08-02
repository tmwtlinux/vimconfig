"cl stand for current line

function ExecuteBash(debug = 0)
  let file_name = expand('%:p')
  if a:debug == 0
    exec "!clear && /bin/bash ".file_name
  elseif a:debug == 1
    exec "!clear && /bin/bash -x ".file_name
  else
    echo "unknow value :".a:debug
    echo "should be 1 or 0"
  endif
endfunction

func! CreateFunctionBody () 
  let cl_num = line('.')
  let cl_value = getline('.')
  let bufnum = bufnr('$')
  if cl_value =~ '^\s*$'
    call setline('.', '# description: ') 
    call setline(cl_num + 1, '# param 1: ...') 
    call setline(cl_num + 2, 'function () {') 
    call setline(cl_num + 3, '  echo "Not implemented yet"')
    call setline(cl_num + 4, '  exit 0')
    call setline(cl_num + 5, '}')
    call setpos('.', [bufnum, cl_num, 15, 0])
  else
    echo 'Line is not empty'
    echo 'refusing to create function body'
  endif
endfunction

" description: create a skeleton for a "for" loop
function CreateForBody ()
  let cl_num = line('.')
  let cl_value = getline('.')
  let cl_offset = len(cl_value)
  let bufnum = bufnr('$')

  if cl_value =~ '^\s*$'
    call setline(cl_num,     cl_value.'for value in ; do')
    call setline(cl_num + 1, cl_value.'  echo "$value";')
    call setline(cl_num + 2, cl_value.'done')
    call setpos('.', [bufnum, cl_num, cl_offset+13, cl_offset])
  else
    echo 'line is not empty'
    echo 'refusing to create for body'
  endif  
endfunction

function CreateWhileBody ()
  let cl_num = line('.')
  let cl_value = getline('.')
  let cl_offset = len(cl_value)
  let bufnum = bufnr('$')
  if cl_value =~ '^\s*$'
    call setline(cl_num,     cl_value.'while ; do')
    call setline(cl_num + 1, cl_value.'  # your code goes here ...;')
    call setline(cl_num + 2, cl_value.'done')
    call setpos('.', [bufnum, cl_num, cl_offset+6, cl_offset])
  else
    echo 'line is not empty'
    echo 'refusing to create while body'
  endif
endfunction

function CreateIfBody()
  let cl_num = line('.')
  let cl_value = getline('.')
  let cl_offset = len(cl_value)
  let bufnum = bufnr('$')

  if cl_value =~ '^\s*$'
    call setline(cl_num,     cl_value.'if ; then')
    call setline(cl_num + 1, cl_value.'  # your code goes here')
    call setpos('.', [bufnum, cl_num, cl_offset+3, cl_offset])
  else
    echo 'line is not empty'
    echo 'refusing to create if'
  endif
endfunction

function CreateElifBody()
  let cl_num = line('.')
  let cl_value = getline('.')
  let cl_offset = len(cl_value)
  let bufnum = bufnr('$')

  if cl_value =~ '^\s*$'
    call setline(cl_num,     cl_value.'elif ; then')
    call setline(cl_num + 1, cl_value.'  # your code goes here')
    call setpos('.', [bufnum, cl_num, cl_offset+5, cl_offset])
  else
    echo 'line is not empty'
    echo 'refusing to create if'
  endif
endfunction

function CreateElseBody()
  let cl_num = line('.')
  let cl_value = getline('.')
  let cl_offset = len(cl_value)
  let bufnum = bufnr('$')

  if cl_value =~ '^\s*$'
    call setline(cl_num,     cl_value.'else')
    call setline(cl_num + 1, cl_value.'  # your code goes here')
    call setline(cl_num + 2, cl_value.'fi')
    call setpos('.', [bufnum, cl_num + 1, cl_offset + 2, cl_offset])
  else
    echo 'line is not empty'
    echo 'refusing to create if'
  endif
endfunction

iabbr func   <esc>:call CreateFunctionBody()<CR>i
iabbr for    <esc>:call CreateForBody()<CR>xi
iabbr while  <esc>:call CreateWhileBody()<CR>xi
iabbr if     <esc>:call CreateIfBody()<CR>xi
iabbr elif   <esc>:call CreateElifBody()<CR>xi
iabbr else   <esc>:call CreateElseBody()<CR>xi

map <leader>x :call ExecuteBash()<CR>
map <leader><C-x> :call ExecuteBash(1)<CR>
