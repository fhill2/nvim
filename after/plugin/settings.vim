
let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_auto_close = 0
let g:nvim_tree_auto_open = 0
let g:nvim_tree_follow = 0
let g:nvim_tree_update_cwd = 0

set ttimeout
set ttimeoutlen=100
set timeoutlen=3000


" :set <F13>=^[[15~
" :map <F13> <cmd>echo "hello world"<cr>


" set <A-F5>=^[[15;3~
" map <A-F5> <cmd>echo "hello a-f5"<cr>

" packer
command! PackerInstall packadd packer.nvim | lua require('plugins').install()
command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
command! PackerSync packadd packer.nvim | lua require('plugins').sync()
command! PackerClean packadd packer.nvim | lua require('plugins').clean()
command! PackerCompile packadd packer.nvim | lua require('plugins').compile()
command! Pi packadd packer.nvim | lua require('plugins').install()
command! Pu packadd packer.nvim | lua require('plugins').update()
command! Psy packadd packer.nvim | lua require('plugins').sync()
command! Pclean packadd packer.nvim | lua require('plugins').clean()
command! Pcompile packadd packer.nvim | lua require('plugins').compile()
command! Pcomp packadd packer.nvim | lua require('plugins').compile()

" float preview
let g:float_preview#docked = 1
" cd to nvim config
"cd "/home/f1/.config/nvim"
let g:dap_virtual_text = 'all frames'
let g:fern#renderer = "nerdfont"
"" reddit output pager into buffer
com -nargs=1 -complete=command Redir
      \ :execute "tabnew | pu=execute(\'" . <q-args> . "\') | setl nomodified" 
      
"nnoremap <F10> <cmd>echo "after plugins were loaded to"<cr>


" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"
"
"

nnoremap <silent> GG :echom screencol()<CR>


" turn on/off logging for format.nvim lukas-reineke
let g:format_debug = v:true
" lukas reineke format.nvim format on save
" augroup Format
"     autocmd!
"     autocmd BufWritePost * FormatWrite
" augroup END



set nobackup
" F: this settings below isnt creating temporary files
" set swapfile
" set dir=~/nvimswapfiles
"
"
"nnoremap <C-t> p
"

if has('nvim')
    augroup terminal_setup | au!
        autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
         augroup end
endif

" turn off auto commenting for every buffer
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o




"set sessionoptions=blank,buffers,curdir,folds,resize,terminal,winpos,winsize

" only 1 left out is 'unix from this list:
" http://vimdoc.sourceforge.net/htmldoc/options.html#'sessionoptions'

" SESSION OPTIONS that i definitely need:
" BLANK OFF - if on, luapad window size changes. but then is luapad window is empty buff dissapears
" CURDIR ON - saves current directory
" WINSIZE ON - to restore window split dimensions.. maybe keeps not restoring
" LOCALOPTIONS ON - to restore treesitter syntax highlighting when loading session


" ALL sessionoptions available below
set sessionoptions=
set sessionoptions-=globals " YOU CANT EXPORT TABLES / DICTS. only strings or numbers. also leave off if i can otherwise it will copy globals that i change 
set sessionoptions+=blank
set sessionoptions+=buffers
set sessionoptions+=curdir
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions+=localoptions
set sessionoptions-=options " global options keeps the state of sessionoptions inside the file so if you change on other nvim the changes wont stick
set sessionoptions-=resize " size of whole vim window ignore
set sessionoptions-=sesdir
set sessionoptions-=slash
set sessionoptions-=tabpages
set sessionoptions-=winpos " position of whole vim window ignore
set sessionoptions+=winsize " each split size






