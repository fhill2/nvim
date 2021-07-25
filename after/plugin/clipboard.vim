" set clipboard=unnamedplus
" let g:clipboard = {
"           \   'name': 'win32yank-wsl',
"           \   'copy': {
"           \      '+': 'win32yank.exe -i --crlf',
"           \      '*': 'win32yank.exe -i --crlf',
"           \    },
"           \   'paste': {
"           \      '+': 'win32yank.exe -o --lf',
"           \      '*': 'win32yank.exe -o --lf',
"           \   },
"           \   'cache_enabled': 0,
"           \ }



set clipboard=unnamedplus
"if system('uname -a | egrep [Mm]icrosoft') != ''
" let g:lastyank = 'y'
" if executable('win32yank.exe')
"    let g:copy = 'win32yank.exe -i --crlf'
"    let g:paste = 'win32yank.exe -o --lf'
" elseif exists('$DISPLAY') && executable('xclip')
"    let g:copy = 'xclip -i -selection clipboard'
"    let g:paste = 'xclip -o -selection clipboard'
" else
"    let g:copy = 'clip.exe'
"    let g:paste = 'powershell.exe Get-Clipboard'
" endif
" augroup myYank
"    autocmd!
"    autocmd TextYankPost * if v:event.operator == 'y' | call system(g:copy, @") | let g:lastyank='y' | else | let g:lastyank='' | endif
"    "autocmd TextYankPost * if v:event.operator ==# 'y' | call system(g:copy, @") | endif
"    "autocmd TextYankPost * call system(g:copy, @")
" augroup END
" function! Paste(mode)
"    if g:lastyank == 'y'
"     let @" = system(g:paste)
"    endif
"    return a:mode
" endfunction
" map <expr> p Paste('p')
" map <expr> P Paste('P')

" " map Ctrl-c and Ctrl-x as expected
" func! GetSelectedText()
"    normal gv"xy
"    let result = getreg("x")
"    return result
" endfunc
" noremap <C-c> :call system(g:copy, GetSelectedText())<CR>
" noremap <C-y> :call system(g:copy, GetSelectedText())<CR>gvx
"endif
