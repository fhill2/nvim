

local nvim_status = require('lsp-status')
local status = require('plugin/lsp/status')
--local completion = require('completion')
--local ultipreview = require('ultipreview')

local log1 = require'log1'



-- sumneko lua language server setup cross platform
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('data')..'/lspserver/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'


local custom_attach = function()
-- local bufpath = vim.api.nvim_buf_get_name(0)
--   local filetype = vim.api.nvim_buf_get_option(0, 'filetype')


-- if bufpath:match('/printoutput[^.]*.lua') ~= nil then
-- log1.info('lsp attached to')
-- log1.info(bufpath)

--completion.on_attach()
--ultipreview.on_attach()

-- else
-- -- important : to not attach lsp to printoutput
-- end


end





-- Load lua configuration from nlua.
-- if true then
--   require('nlua.lsp.nvim').setup(lspconfig, {
--     on_attach = custom_att

--     globals = {
--       -- Colorbuddy
--       "Color", "c", "Group", "g", "s",

--       -- Custom
--       "RELOAD",
--     }
--   })
-- else


-- old lua setup without nlua
require'lspconfig'.sumneko_lua.setup {
  on_attach = custom_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {

    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable=true,
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'l', 'p', 'po' },
        disable = { 'empty-block' }
      },
      workspace = {
        ignoreDir = { '.printoutput' },
        maxPreload = 1000000,
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  filetypes = { "lua", "lua.luapad" }
}

require'lspconfig'.vimls.setup{
  on_attach = custom_attach,
cmd = { "vim-language-server", "--stdio" },
    filetypes = { "vim" },
    init_options = {
      diagnostic = {
        enable = true
      },
      indexes = {
        count = 3,
        gap = 100,
        projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
        runtimepath = true
      },
      iskeyword = "@,48-57,_,192-255,-#",
      runtimepath = "",
      suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
      },
      vimruntime = ""
    }

    }







require'lspconfig'.bashls.setup{
    on_attach = custom_attach,
cmd = { "bash-language-server", "start" },
    cmd_env = {
      GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
    },
    filetypes = { 'sh', 'bash', 'zsh', 'term' },
   -- root_dir = , -- vim's starting directorya
}

-- require'lspconfig'.tsserver.setup{on_attach = custom_attach}


require'lspconfig'.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
    on_attach = custom_attach
  })




require'lspconfig'.yamlls.setup{
    on_attach = custom_attach,
cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
   -- root_dir = root_pattern(".git", vim.fn.getcwd())

}


require'lspconfig'.jsonls.setup{

cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { "json" },
    init_options = {
      provideFormatter = true
    },
   -- root_dir = root_pattern(".git", vim.fn.getcwd())
}

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])








-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = require'completion'.on_attach,
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--     -- Colorbuddy
--     "Color", "c", "Group", "g", "s",
--   }
-- })


-- -- new nlua tj devries lua
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = on_attach,

--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--     -- Colorbuddy
--     "Color", "c", "Group", "g", "s",
--   }
-- })





-- {
--   on_attach=require'completion'.on_attach,
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
-- })
-- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")


-- require'lspconfig'.vimls.setup{}


-- Your custom attach function for nvim-lspconfig goes here.
-- local custom_nvim_lspconfig_attach = function(...) end

-- -- To get builtin LSP running, do something like:
-- -- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = custom_nvim_lspconfig_attach,

--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--     -- Colorbuddy
--     "Color", "c", "Group", "g", "s",
--   }
-- })


-- local has_completion, completion = pcall(require, 'completion')

-- local on_attach = function(client, bufnr)
--   local resolved_capabilities = client.resolved_capabilities

--   if has_diagnostic then
--     -- diagnostic.on_attach()
--   end

--   if has_completion then
--     completion.on_attach()
--   end


