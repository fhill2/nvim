local api = vim.api
local log1 = require "log1"
-- api.nvim_set_keymap("", "<A-r>s", [[<cmd>lua require'keymap/luapad'.start_luapad_noeval()<cr>]], {})
-- api.nvim_set_keymap("!", "<A-r>s", [[<cmd>lua require'keymap/luapad'.start_luapad_noeval()<cr>]], {})

-- luafile %
api.nvim_set_keymap("", "<A-r>a", [[<cmd>luafile %<cr>]], {})
api.nvim_set_keymap("!", "<A-r>a", [[<cmd>luafile %<cr>]], {})


-- attaches luapad to current buffer, and if already attached, runs it
api.nvim_set_keymap("", "<A-r>r", [[<cmd>lua require'plugin/luapad'.manual_eval()<cr>]], {})
api.nvim_set_keymap("!", "<A-r>r", [[<cmd>lua require'plugin/luapad'.manual_eval()<cr>]], {})

-- toggle editor eval on change true false
api.nvim_set_keymap("", "<A-r>t", [[<cmd>lua require'plugin/luapad'.toggle_eval_on_change()<cr>]], {})
api.nvim_set_keymap("!", "<A-r>t", [[<cmd>lua require'plugin/luapad'.toggle_eval_on_change()<cr>]], {})


api.nvim_set_keymap("", "<A-h>r", [[<cmd>lua require'shell-repl'.attach({ eval_on_change = false })<cr>]], {})
api.nvim_set_keymap("!", "<A-h>r", [[<cmd>lua require'shell-repl'.attach({ eval_on_change = false})<cr>]], {})
api.nvim_set_keymap("", "<A-h>t", [[<cmd>lua require'shell-repl'.set_eval_on_change(true)<cr>]], {})
api.nvim_set_keymap("!", "<A-h>t", [[<cmd>lua require'shell-repl'.set_eval_on_change(true)<cr>]], {})
api.nvim_set_keymap("", "<A-h>y", [[<cmd>lua require'shell-repl'.set_eval_on_change(false)<cr>]], {})
api.nvim_set_keymap("!", "<A-h>y", [[<cmd>lua require'shell-repl'.set_eval_on_change(false)<cr>]], {})
api.nvim_set_keymap("", "<A-h>u", [[<cmd>lua require'shell-repl'.detach()<cr>]], {})
api.nvim_set_keymap("!", "<A-h>u", [[<cmd>lua require'shell-repl'.detach()<cr>]], {})

api.nvim_set_keymap("", "<A-h>h", [[<cmd>lua require'shell-repl'.eval()<cr>]], {})
api.nvim_set_keymap("!", "<A-h>h", [[<cmd>lua require'shell-repl'.eval()<cr>]], {})


api.nvim_set_keymap("", "<A-j>l", [[<cmd>lua require'plugin/iron'.send_whole_file()<cr>]], {})
api.nvim_set_keymap("!", "<A-j>l", [[<cmd>lua require'plugin/iron'.send_whole_file()<cr>]], {})

api.nvim_set_keymap("", "<A-j>j", [[<cmd>lua require("iron").core.send_line()<cr>
]], {})
api.nvim_set_keymap("!", "<A-j>j", [[<cmd>lua require("iron").core.send_line()<cr>
]], {})

api.nvim_set_keymap("", "<A-j>k", [[<cmd>lua require("iron").core.send(vim.bo.ft, vim.fn.expand("%"))
<cr>]], {})
api.nvim_set_keymap("!", "<A-j>k", [[<cmd>lua require("iron").core.send(vim.bo.ft, vim.fn.expand("%"))
<cr>
]], {})


api.nvim_set_keymap("", "<A-j>l", [[<cmd>lua require("iron").core.visual_send()<cr>
]], {})
api.nvim_set_keymap("!", "<A-j>l", [[<cmd>lua require("iron").core.visual_send()<cr>
]], {})


