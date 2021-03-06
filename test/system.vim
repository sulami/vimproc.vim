let s:suite = themis#suite('system')
let s:assert = themis#helper('assert')

function! s:check_ls()
  if !executable('ls')
    call s:assert.skip('ls command is not installed.')
  endif
endfunction

function! s:suite.system1()
  call s:check_ls()
  call s:assert.equals(vimproc#system('ls'), system('ls'))
endfunction

function! s:suite.system2()
  call s:check_ls()
  call s:assert.equals(vimproc#system(['ls']), system('ls'))
endfunction

function! s:suite.cmd_system1()
  call s:check_ls()
  call s:assert.equals(vimproc#cmd#system('ls'), system('ls'))
endfunction

function! s:suite.cmd_system2()
  call s:check_ls()
  call s:assert.equals(vimproc#cmd#system(['ls']), system('ls'))
endfunction

function! s:suite.cmd_system3()
  call s:assert.equals(
        \ vimproc#cmd#system(['echo', '"Foo"']),
        \ "\"Foo\"\n")
endfunction

function! s:suite.system_passwd1()
  if vimproc#util#is_windows()
    call s:assert.skip('')
  endif
  call s:assert.equals(
        \ vimproc#system_passwd('echo -n test'),
        \ system('echo -n test'))
endfunction

function! s:suite.system_passwd2()
  if vimproc#util#is_windows()
    call s:assert.skip('')
  endif
  call s:assert.equals(
        \ vimproc#system_passwd(['echo', '-n', 'test']),
        \ system('echo -n test'))
endfunction

function! s:suite.system_and1()
  if vimproc#util#is_windows()
    call s:assert.skip('')
  endif
  call s:check_ls()
  call s:assert.equals(vimproc#system('ls&'), '')
endfunction

function! s:suite.system_and2()
  if vimproc#util#is_windows()
    call s:assert.skip('')
  endif
  call s:check_ls()
  call s:assert.equals(vimproc#system('ls&'),
        \ vimproc#system_bg('ls'))
endfunction

function! s:suite.system_bg1()
  call s:check_ls()
  call s:assert.equals(vimproc#system_bg('ls'), '')
endfunction

function! s:suite.system_bg2()
  call s:check_ls()
  call s:assert.equals(vimproc#system_bg(['ls']), '')
endfunction

function! s:suite.password_pattern()
  call s:assert.match(
        \ 'Enter passphrase for key ''.ssh/id_rsa''',
        \ g:vimproc_password_pattern)
endfunction

" vim:foldmethod=marker:fen:
