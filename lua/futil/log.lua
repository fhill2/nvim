local M = {}


function M.log(...)





local info = debug.getinfo(3, "Sl") or nil
if info == nil then 
info = debug.getinfo(2, 'Sl') or ''
end

local lineinfo = string.format('%s:%s', info.source:gsub('@', ''), info.currentline) 

local filepath_to_write = '/home/f1/.local/share/nvim/logs/nvim.log'

if info.source:find('/home/f1/.local/share/nvim/site/pack/packer/opt/format.nvim', 1, true) ~= nil then
filepath_to_write = '/home/f1/.local/share/nvim/logs/format.log'
elseif info.source:find('/home/f1/.config/nvim/lua/futil/clipboard.lua', 1, true) ~= nil then
filepath_to_write = '/home/f1/.local/share/nvim/logs/clipboard.log'
end

local msg = vim.tbl_map(function(input)    
if type(input) == nil then
input = 'nil'

elseif type(input) == 'table' then
-- f: this need to not be local for it to work
input = vim.inspect(input)

elseif type(input) == 'string' then
end
return input

end, {...})




local msg = table.concat(msg, ' ')

     local fp = io.open(filepath_to_write, "a")
  local str = string.format("[%s] %s: %s \n",
      os.date(), lineinfo, msg)
      fp:write(str)


      fp:close()
end



return M
