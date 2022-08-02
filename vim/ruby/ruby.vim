function ExecuteRuby()
  let file_name=expand('%:p')
  execute "!clear && /usr/bin/ruby -w ".file_name
endfunction

map <leader>x :call ExecuteRuby()<CR>
