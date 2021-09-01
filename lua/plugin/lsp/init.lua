-- https://github.com/kabouzeid/nvim-lspinstall/wiki

local log = require("log1")

local lspconfig = require("lspconfig")


local lsp_signature_config = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },

  trigger_on_newline = true, -- sometime show signature on new line can be confusing, set it to false for #58
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}



local luadev = require("lua-dev").setup({
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  -- pass any additional options that will be merged in the final lsp config
  lspconfig = {
    -- cmd = {"lua-language-server"},
    -- on_attach = ...
  },
})

-- keymaps
local on_attach = function(client, bufnr)

require "lsp_signature".on_attach(lsp_signature_config)


  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

  -- Set autocommands conditional on server_capabilities
  --if client.resolved_capabilities.document_highlight then
  -- vim.api.nvim_exec([[
  -- augroup lsp_document_highlight
  -- autocmd! * <buffer>
  --autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  -- augroup END
  -- ]], false)
  --end
  --
  --
end

-- After using :LspInstall <server> command, nvim lsp is reloaded (bypasses restarting nvim)
require("lspinstall").post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


-- Configure lua language server for neovim development
-- f: my old lua settings
-- local lua_settings = {
--   Lua = {
--     runtime = {
--       -- LuaJIT in the case of Neovim
--       version = 'LuaJIT',
--       path = vim.split(package.path, ';'),
--     },
--     diagnostics = {
--       -- Get the language server to recognize the `vim` global
--       globals = {'vim'},
--     },
--     workspace = {
--       -- Make the server aware of Neovim runtime files
--       library = {
--         [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--         [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--       },
--       maxPreload = 5000,
--       preloadFileSize = 1000,
--     },
--   }
-- }

-- config that activates keymaps and enables snippet support
local function make_config()
  --local capabilities = vim.lsp.protocol.make_client_capabilities()
  --capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    --capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require("lspinstall").setup()

  -- get all installed servers
  local servers = require("lspinstall").installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      --config.settings = luadev
      --log.info("setup!")
      --log.info(luadev)
      --log.info(config)
      --log.info(vim.tbl_deep_extend("force", luadev, config))
      lspconfig.lua.setup(vim.tbl_deep_extend("force", luadev, config))
    else
      lspconfig[server].setup(config)
    end
  end
end

setup_servers()

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
