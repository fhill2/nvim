require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 20,

  --function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,

  open_mapping = [[<a-l>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal', --  | 'horizontal' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'single', --| 'double' | 'shadow' | 'curved' | ... other options supported by win open
    width = 30,
    height = 20,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}


local log = require'log1'

-- works without shell wrapper fn

local get_init = require('xplr.utils').get_init 
local get_root = require('xplr.utils').get_root 
local Terminal  = require('toggleterm.terminal').Terminal
local cmd = ('export NVIM_XPLR_ROOT=%s && xplr -C "%s"'):format(get_root(), get_init())
local xplr = Terminal:new({ 
  cmd = cmd, 
  hidden = true, 
  on_open = function(term)
      log.info(term)
      end



})

function _xplr_toggle()
  xplr:toggle()
end

vim.api.nvim_set_keymap("n", "<space>k", "<cmd>lua _xplr_toggle()<CR>", {noremap = true, silent = true})




