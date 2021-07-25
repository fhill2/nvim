let g:python3_host_prog = '/usr/bin/python3'
let g:completion_enable_snippet = 'UltiSnips'


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_confirm_key = "\<C-Space>"
let g:completion_trigger_on_delete = 1
"primagean
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']




" REMEMBER turning these on means you wont be able to use Tab key. dont know why
" let g:UltiSnipsExpandTrigger='<F5>'
" let g:UltiSnipsListSnippets='<F6>'
" let g:UltiSnipsJumpForwardTrigger='<F7>'
" let g:UltiSnipsJumpBackwardTrigger='<F8>'


" deoplete specific settings
let g:deoplete#enable_at_startup = 1




" nvim-lightbulb config



" OLD NOT USING


" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <C-Tab> pumvisible() ? "\<C-p>" : "\<C-Tab>"
" inoremap <expr> <Esc> pumvisible() ? "\<C-o>". ":startinsert". "\<cr>" : "\<Esc>"
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <C-Tab> pumvisible() ? "\<C-p>" : "\<C-Tab>"


""inoremap <expr> <Esc> pumvisible() ? "\<C-o>". ":startinsert". "\<cr>" : "\<Esc>"

"inoremap <expr> <Esc> pumvisible() ? "\<C-o>\<C-o>" : "\<Esc>"


"" close completion window
""inoremap <expr> <C-A> pumvisible() ? "\<C-o>il" : "\<C-A>"


"inoremap <expr> <Up>   pumvisible() ? "\<C-n>i<Up>" : "\<Up>"
"inoremap <expr> <Down>   pumvisible() ? "\<C-n>i<Down>" : "\<Down>"

