" let g:codi#interpreters = {
"       \  'lua': {
"       \ 'bin': 'lua',
"       \ },
"       \}

let g:codi#interpreters = {
\ 'zsh': {
\ 'bin': ['zsh'],
\ 'prompt': '^\(>\|\.\.\.\+\) ',
\ }
\ }





"\ 'prompt': '^(archLinux%) ',

" removes secondary window and prints the output as inline virtual text
let g:codi#virtual_text = 0

let g:codi#raw=1


let g:codi#virtual_text_prefix = " >>>> "
highlight CodiVirtualText guifg=cyan
hi ColorColumn ctermbg=NONE 
                 hi VertSplit ctermbg=NONE 
                 hi NonText ctermfg=0 
                 "let g:codi#raw=1



"echo "CODI LOADED"

let g:codi#log = '/home/f1/logs/nvim-plugins/codi.log'
