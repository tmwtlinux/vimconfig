
let ansible_modules = [ 'ansible.builtin.apt', 
\ 'ansible.builtin.apt_key', 
\ 'ansible.builtin.apt_repository', 
\ 'ansible.builtin.assemble', 
\ 'ansible.builtin.blockinfile', 
\ 'ansible.builtin.file', 
\ 'ansible.builtin.systemd', 
\ 'ansible.builtin.template',
\ 'ansible.builtin.lineinfile']


function AnsibleModuleSelect(id, result)
  let myList = filter(copy(g:ansible_modules), 'v:val !~ ".*infile"' )
  echo myList
  call setline('.', '    '.g:ansible_modules[a:result - 1].':')
endfunction


map <leader>l :call popup_menu(ansible_modules, #{callback: 'AnsibleModuleSelect'} )<CR>
