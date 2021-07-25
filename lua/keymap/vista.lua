local api = vim.api

api.nvim_set_keymap('', '<A-v>v', [[<cmd>Vista<cr>]], {})
api.nvim_set_keymap('!', '<A-v>v', [[<cmd>Vista<cr>]], {})


api.nvim_set_keymap('', '<A-v>v', [[<cmd>Vista fzf:nvim_lsp<cr>]], {})
api.nvim_set_keymap('!', '<A-v>v', [[<cmd>Vista fzf:nvim_lsp<cr>]], {})



api.nvim_set_keymap('', '<A-v>s', [[<cmd>Telescope lsp_document_symbols<cr>]], {})
api.nvim_set_keymap('!', '<A-v>s', [[<cmd>Telescope lsp_document_symbols<cr>]], {})
api.nvim_set_keymap('', '<A-v>d', [[<cmd>Telescope lsp_workspace_symbols<cr>]], {})
api.nvim_set_keymap('!', '<A-v>d', [[<cmd>Telescope lsp_workspace_symbols<cr>]], {})




