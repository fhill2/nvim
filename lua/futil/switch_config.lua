local switch = {}
local uv = vim.loop

switch.switch_config = function(next_config)
-- get current nvim config
local current_fp = uv.fs_readlink(vim.fn.stdpath('config'))
local _, _, current_config = current_fp:find('configs/nvim%-(.*)')

if current_config == next_config then print('CONFIG already ' .. next_config) return end

local next_config_fp = '/home/f1/.config/nvim-configs/nvim-' .. next_config
local nvim_fp = vim.fn.stdpath('config')

-- check if symlink first, if not DONT run command
if uv.fs_lstat(nvim_fp).type == 'link' then
local cmd = string.format('!rm %s && ln -s %s/ %s', nvim_fp, next_config_fp, nvim_fp)
vim.cmd(cmd)
end

print('switched to ' .. next_config ..  'config. Restart')


return current_config
end

-- lua require'futil/switch_config'.switch_config('2 or main')


-- switch.switch_main = function()
-- local next_config = 'main'
-- local current_config = switch.switch_config(next_config)


-- end


-- switch.switch_2nd = function()


-- print('switched to test config. Restart')
-- end

return switch
