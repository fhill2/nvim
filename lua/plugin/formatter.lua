--https://github.com/elianiva/dotfiles/blob/master/nvim/.config/nvim/lua/plugins/_formatter.lua


local prettier = function()
  -- if is_cfg_present("/.prettierrc") then
  --   return {
  --     exe = "prettier",
  --     args = {
  --       "--stdin-filepath",
  --       vim.api.nvim_buf_get_name(0),
  --       "--config",
  --       vim.loop.cwd() .. "/.prettierrc"
  --     },
  --     stdin = true,
  --   }
  -- end
  -- fallback to global config
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      vim.api.nvim_buf_get_name(0),
     -- "--config",
     -- "~/cl/format/elianiva.prettierrc"
    },
    stdin = true,
  }
end
-- local denofmt = function()
--   return {
--     exe = "deno",
--     args = { "fmt", "-" },
--     stdin = true,
--   }
-- end
local rustfmt = function()
  return {
    exe = "rustfmt",
    args = { "--emit=stdout" },
    stdin = true,
  }
end
local dartfmt = function()
  return {
    exe = "dartfmt",
    args = { "--fix" },
    stdin = true,
  }
end
local gofmt = function()
  return {
    exe = "gofumpt",
    stdin = true,
  }
end
local stylua = function()
  return {
    exe = "stylua",
    args = {
      "--config-path",
      "~/cl/format/stylua/nui.toml",
      "-"
    },
    stdin = true,
  }
end
require("formatter").setup({
  logging = true,
  filetype = {
    typescriptreact = { prettier },
    javascript = { prettier },
    typescript = { prettier },
    svelte     = { prettier },
    css        = { prettier },
    jsonc      = { prettier },
    json       = { prettier },
    html       = { prettier },
    php        = { prettier },
    rust       = { rustfmt },
    go         = { gofmt },
    lua        = { stylua },
    dart       = { dartfmt },
  },
})
