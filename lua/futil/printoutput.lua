
local M = {}

local log1 = require'log1'
M.jump = false


local print_output_path = vim.fn.stdpath('data') .. '/printoutput.lua'
local print_refresh_path = vim.fn.stdpath('data') .. '/printrefresh.lua'








function M.open_or_refresh_window(filepath)
-- this function retrieves current bufnr if window is open
-- or creates a new buffer and returns the bufnr
local visiblebufs = vim.fn.getbufinfo({buflisted = 1})

for k, v in pairs(visiblebufs) do
    if v.name == filepath then
vim.api.nvim_buf_call(v.bufnr, function()
 vim.cmd('edit!')
            end)
           
            return v.bufnr
        -- GET BUFFER NUMBER AND RETURN INSTEAD
    end
end


local bufnr = vim.api.nvim_create_buf(true, true)


vim.api.nvim_buf_call(bufnr, function() 
        vim.cmd('e' .. filepath) 
        vim.bo.filetype = 'lua' 
    end)


return bufnr

end






local function prepare_data(msg)
if type(msg) == 'nil' then
msg = 'nil'

elseif type(msg) == 'table' then
-- f: this need to not be local for it to work
msg = vim.inspect(msg)
msg = 'out = ' .. msg

elseif type(msg) == 'string' then
msg = "'" .. msg .. "'"
end

return msg
end




function M.po(msg)
-- print output, no overwrite, append

vim.g.printoutputjump = true
local bufnr = M.open_or_refresh_window(print_output_path)

local msg = prepare_data(msg)

local fp = io.open(print_output_path, "a")
fp:write('-----------------------------\n' .. msg .. '\n')
fp:close()
end


function M.pr(msg)
-- print refresh, overwrite

vim.g.printoutputjump = true
local bufnr = M.open_or_refresh_window(print_refresh_path)

local msg = prepare_data(msg)

local fp2 = io.open(print_refresh_path, "w")
fp2:write('-----------------------------\n' .. msg .. '\n')
fp2:close()
end



 function M.printoutput_onBufEnter() 

    local bufnr = vim.api.nvim_get_current_buf()
if vim.api.nvim_buf_get_name(bufnr) == print_output_path or vim.api.nvim_buf_get_name(bufnr) == print_refresh_path then
if vim.g.printoutputjump == true then
      --  log1.info('JUMP TRIGERRED')
        vim.api.nvim_feedkeys('G', 'n', false)
 vim.g.printoutputjump = false
    end
    end

 
end



return M
