local api = vim.api

--- =============== ADDED TO OMNIMENU
-- api.nvim_set_keymap('', '<F5>', [[<cmd>lua require('floating').close_all()<cr>]], {}) -- close all floating windows
-- api.nvim_set_keymap('!', '<F5>', [[<cmd>lua require('floating').close_all()<cr>]], {})


--- =============== ADDED TO OMNIMENU END

local opts = { noremap = true}

--api.nvim_set_keymap('n', 'G', '<cmd>normal! G<cr>', { noremap = true})
-- Lwin trigger comand line 
--api.nvim_set_keymap('n', ':', '<Nop>', { noremap = true})
api.nvim_set_keymap('n', '<F23>', ':', { noremap = true})
api.nvim_set_keymap('i', '<F23>', [[<c-\><c-n> :]], { noremap = true})
api.nvim_set_keymap('c', '<F23>', '<cr>', { noremap = true})



-- floating
api.nvim_set_keymap('', '<F4>', [[<cmd>luafile %<cr>]], {})
api.nvim_set_keymap('!', '<F4>', [[<cmd>luafile %<cr>]], {})

--api.nvim_set_keymap('n', '<C-@>', [[<cmd>lua print('hello world')<cr>]], {})


-- alt test

-- TABS FOCUSING
api.nvim_set_keymap('n', '<space>1', [[1gt]], opts)
api.nvim_set_keymap('n', '<space>2', [[2gt]], opts)
api.nvim_set_keymap('n', '<space>3', [[3gt]], opts)
api.nvim_set_keymap('n', '<space>4', [[4gt]], opts)
api.nvim_set_keymap('n', '<space>5', [[5gt]], opts)
api.nvim_set_keymap('n', '<space>6', [[6gt]], opts)
api.nvim_set_keymap('n', '<space>7', [[7gt]], opts)
api.nvim_set_keymap('n', '<space>8', [[8gt]], opts)

-- SPLITS FOCUSING
api.nvim_set_keymap('n', "<C-h>", "<C-w>h", { silent = true })
api.nvim_set_keymap('n', "<C-j>", "<C-w>j", { silent = true})
api.nvim_set_keymap('n', "<C-k>", "<C-w>k", { silent = true })
api.nvim_set_keymap('n', "<C-l>", "<C-w>l", { silent = true })


-- ALL CYCLING
-- q:next tab:prev
api.nvim_set_keymap('n', '<space>q', [[<cmd>tabn<cr>]], opts)
api.nvim_set_keymap('n', '<space><Tab>', [[<cmd>tabp<cr>]], opts)

api.nvim_set_keymap('n', "q", "<cmd>wincmd w<cr>", { silent = true, noremap = true })
api.nvim_set_keymap('n', "<Tab>", "<cmd>wincmd W<cr>", { silent = true, noremap = true })

api.nvim_set_keymap('n', '<C-q>', '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true }) -- F19=Ctrl-Tab
api.nvim_set_keymap('n', '<F19>', '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })



api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"xplr.actions".send_request()<cr>', { noremap = true, silent = true })
api.nvim_set_keymap('t', '<F9>', '<cmd>lua require"xplr.actions".send_request()<cr>', { noremap = true, silent = true })


-- CLOSING QUITTING

-- close window
api.nvim_set_keymap('n', '<C-w>', '<cmd>q<cr>', { noremap = true})
api.nvim_set_keymap('i', '<C-w>', '<cmd>q<cr>', { noremap = true})
api.nvim_set_keymap('v', '<C-w>', '<cmd>q<cr>', { noremap = true})

-- close buffer and keep window
api.nvim_set_keymap('n', '<space>w', '<cmd>Bdelete!<cr>', {})

--close window in terminal
api.nvim_set_keymap('t', '<space>w', [[<C-\><C-n><C-q>]], {})

-- terminals
api.nvim_set_keymap('n', '<space>gg', '<cmd>lua require"futil.terminal".new()<cr>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<space>gh', '<cmd>lua require"futil.terminal".focus_cycle()<cr>', { noremap = true, silent = true })

-- enter terminal
api.nvim_set_keymap('n', '<C-Space>', '<cmd>startinsert()<cr>', { noremap = true, silent = true })


-- exit terminal
api.nvim_set_keymap('t', '<C-Space>', '<cmd>lua require"futil/terminal".exit_term()<cr>', { noremap = true, silent = true })



-- api.nvim_set_keymap('', '<space>w', '<cmd>q<cr>', {})
-- api.nvim_set_keymap('i', '<space>w', '<cmd>q<cr>', {})
-- api.nvim_set_keymap('v', '<space>w', '<cmd>q<cr>', {})

--api.nvim_set_keymap('n', "<C-Space>h", "lua print('echo hello world')", {  })



-- livetablelogger
-- api.nvim_set_keymap('', '<A-3>', [[<cmd>lua require("livetablelogger").open({ view1 = { target = 'g_fstate_/home/f1/.config/nvim/init.lua'}})<cr>]], {})
-- api.nvim_set_keymap('!', '<A-3>', [[<cmd>lua require("livetablelogger").open({ view1 = { target = 'g_fstate_/home/f1/.config/nvim/init.lua'}})<cr>]], {})

-- api.nvim_set_keymap('', '<A-4>', [[<cmd>lua require("livetablelogger").open({ view2 = { target = 'g_fstate_/home/f1/.config/nvim/init.lua'}})<cr>]], {})
-- api.nvim_set_keymap('!', '<A-4>', [[<cmd>lua require("livetablelogger").open({ view2 = { target = 'g_fstate_/home/f1/.config/nvim/init.lua'}})<cr>]], {})



-- api.nvim_set_keymap('', '<A-3>f', [[<cmd>lua require("livetablelogger").focus()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-3>f', [[<cmd>lua require("livetablelogger").focus()<cr>]], {})




-- for map, leave 1st argument as blank
-- for map, 1st argument = '!'
-- 2nd 3rd argument are hotkey action
-- 4th is options
-- 4th: for noremap: , {noremap = true})
-- api.nvim_set_keymap('', '', '', {})
-- api.nvim_set_keymap('', '', [[]], {})



-- api.nvim_set_keymap('i', '<c-q>', '<cmd>echo "hello world"<cr>', {})
-- api.nvim_set_keymap('i', '<F10>', '<c-q>', {})


-- api.nvim_set_keymap('', '<F14>', '<cmd>qa!<cr>', {})
-- api.nvim_set_keymap('', '<F14>', '<cmd>qa!<cr>', {})
-- api.nvim_set_keymap('!', '<F14>', '<cmd>qa!<cr>', {})
-- cut copy paste undo
api.nvim_set_keymap('', '<C-x>', 'd', {})
api.nvim_set_keymap('!', '<C-x>', '<Esc>d', {})
api.nvim_set_keymap('v', '<C-c>', 'y<Esc>', { noremap = true })

api.nvim_set_keymap('n', '<C-v>', 'p', { noremap = true })
api.nvim_set_keymap('i', '<C-v>', '<Esc>p', { noremap = true })
api.nvim_set_keymap('c', '<C-v>', '<C-R>+', { noremap = true })





api.nvim_set_keymap('', '<C-z>', 'u', {})
api.nvim_set_keymap('!', '<C-z>', '<Esc>p', {})
-- end cut copy paste undo 

-- insert new line enter in normal mode
api.nvim_set_keymap('n', '<cr>', [[o<Esc>]], {})

-- backspace in normal mode
api.nvim_set_keymap('n', '<BS>', [[i<BS><ESC>]], {})
-- save
api.nvim_set_keymap('', '<c-s>', '<cmd>w<cr>', {})
api.nvim_set_keymap('!', '<c-s>', '<cmd>w<cr>', {})




-- WINDOW SPLITS

api.nvim_set_keymap('n', "<C-a>d", "<cmd>vsp<cr>", { silent = true })
api.nvim_set_keymap('n', "<C-a>f", "<cmd>sp<cr>", { silent = true })
api.nvim_set_keymap('n', "<C-a>c", "<cmd>bo 30split<cr>", { silent = true })
api.nvim_set_keymap('n', "<C-a>e", "<cmd>to 31split<cr>", { silent = true })


-- close buffer
-- api.nvim_set_keymap('', '<c-w>', '<cmd>bdelete<cr>', {})
-- api.nvim_set_keymap('!', '<c-w>', '<cmd>bdelete<cr>', {})

--delete into blackhole buffer
--api.nvim_set_keymap('', '<Delete>', 'd "_d', {})
--api.nvim_set_keymap('!', '<Delete>', 'd "_d', {})

--nnoremom screencol()p <silent> GG :echom screencol()<CR>
-- api.nvim_set_keymap('', '<A-8>', [[echom screencol()]], {})


-- api.nvim_set_keymap('', '<A-i>', [[<cmd>lua require("futil").test()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-i>', [[<cmd>lua require("futil").test()<cr>]], {})

-- manual reload whole config
api.nvim_set_keymap('', '<A-p>', [[<cmd>lua require("futil/resource").resource_init_only()<cr>]], {})
api.nvim_set_keymap('!', '<A-p>', [[<cmd>lua require("futil/resource").resource_init_only()<cr>]], {})
api.nvim_set_keymap('', '<A-o>', [[<cmd>lua require('futil/resource').resource_single_file()<cr>]], {})
api.nvim_set_keymap('!', '<A-o>', [[<cmd>lua require("futil/resource").resource_single_file()<cr>]], {})


--api.nvim_set_keymap('', '', [[]], {})
--api.nvim_set_keymap('', '', [[]], {})


--search
api.nvim_set_keymap('n', '<C-f>', [[/]], {})
api.nvim_set_keymap('i', '<C-f>', [[<Esc>/]], {})
api.nvim_set_keymap('c', '<C-f>', [[<Esc>]], {})



api.nvim_set_keymap('', '<M-h>', '<Plug>(Luadev-RunLine)<CR>', {})
api.nvim_set_keymap('n', '<Leader>f', '<cmd>Luadev<cr>', { noremap = true})


-- api.nvim_set_keymap('', '<A-s>q', '<cmd>SClose<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>q', '<cmd>SClose<cr>', {})
-- api.nvim_set_keymap('', '<A-s>d', '<cmd>SDelete<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>d', '<cmd>SDelete<cr>', {})
-- api.nvim_set_keymap('', '<A-s>l', '<cmd>SLoad<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>l', '<cmd>SLoad<cr>', {})
-- api.nvim_set_keymap('', '<A-s>o', '<cmd>SLoad<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>o', '<cmd>SLoad<cr>', {})
-- api.nvim_set_keymap('', '<A-s>h', '<cmd>Startify<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>h', '<cmd>Startify<cr>', {})
-- api.nvim_set_keymap('', '<A-s>s', '<cmd>SSave<cr>', {})
-- api.nvim_set_keymap('!', '<A-s>s', '<cmd>SSave<cr>', {})


-- snippet stuff
api.nvim_set_keymap('', '<A-y>', [[<cmd>lua require'futil'.saveSnippet()<cr>]], {})
api.nvim_set_keymap('!', '<A-y>', [[<cmd>lua require'futil'.saveSnippet()<cr>]], {})
-- api.nvim_set_keymap('', '<A-g>', '<cmd>call UltiSnips#ListSnippets()<cr>', {})
-- api.nvim_set_keymap('!', '<A-g>', '<cmd>call UltiSnips#ListSnippets()<cr>', {})


-- btm window stuff + window manip
-- api.nvim_set_keymap('', '<C-`>', [[<cmd>lua require'futil/btmwindow'.toggleBtmWindow()<cr>]], {})
-- api.nvim_set_keymap('!', '<C-`>', [[<cmd>lua require'futil/btmwindow'.toggleBtmWindow()<cr>]], {})
api.nvim_set_keymap('', '<A-e>', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("luapad")<cr>]], {})
api.nvim_set_keymap('!', '<A-e>', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("luapad")<cr>]], {})
-- api.nvim_set_keymap('', '<A-t>t', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("fterminal")<cr>]], {})
-- api.nvim_set_keymap('!', '<A-t>t', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("fterminal")<cr>]], {})
-- api.nvim_set_keymap('', '<A-]>', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("quickfix")<cr>]], {})
-- api.nvim_set_keymap('!', '<A-]>', [[<cmd>lua require'futil/btmwindow'.toggle_btm_win_single("quickfix")<cr>]], {})
-- api.nvim_set_keymap('', '<A-1>', '<cmd>lua require("futil/window").focusWindow(1)<cr>', {})
-- api.nvim_set_keymap('!', '<A-1>', '<cmd>lua require("futil/window").focusWindow(1)<cr>', {})
-- api.nvim_set_keymap('', '<A-2>', '<cmd>lua require("futil/window").focusWindow(2)<cr>', {})
-- api.nvim_set_keymap('!', '<A-2>', '<cmd>lua require("futil/window").focusWindow(2)<cr>', {})
-- api.nvim_set_keymap('', '<A-3>', '<cmd>lua require("futil/window").focusWindow(3)<cr>', {})
-- api.nvim_set_keymap('!', '<A-2>', '<cmd>lua require("futil/window").focusWindow(3)<cr>', {})
