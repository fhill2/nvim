local log = require'log1'


local futil = {}
function futil.close_buffer()
  -- better closing buffers, that:
  -- if nvim tree is open, every buffer that is closed, it wont close the window. it will open blank buffer before and load it into window, then close original buffer
  -- 

  local treeView = require('nvim-tree.view')
  local bufferline = require('bufferline')

  -- check if NvimTree window was open
  local explorerWindow = treeView.get_winnr()
  local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

  local bufferToDelete = vim.api.nvim_get_current_buf()

  -- TODO: handle modified buffers
  -- local isModified = vim.api.nvim_eval('getbufvar(' .. bufferToDelete .. ', "&mod")')

  if (wasExplorerOpen) then
    -- switch to previous buffer (tracked by bufferline)
    bufferline.cycle(-1)
  end

  -- delete initially open buffer
  vim.cmd('bdelete! ' .. bufferToDelete)
end


return futil
