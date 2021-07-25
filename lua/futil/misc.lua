local log1 = require('log1')
local M = {}

local utils = require'futil/utils'

function M._get_visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    return csrow - 1, cscol - 1, cerow - 1, cecol
  else
    return cerow - 1, cecol - 1, csrow - 1, cscol
  end
end





-- THIS FUNCTION KEYMAPPED TO ALT-I
function M.test()
--lo(repeating)
--vim.api.nvim_buf_set_lines(50, 0, -1, true, utils.repeated_table(200, 'a'))
end





function M.snippetsList()
   local snippetsList = vim.call('UltiSnips#SnippetsInCurrentScope', 1)

    --local snippetsList = vim.call('UltiSnips#ListSnippets')
  
  --  print(vim.inspect(vim.g.current_ulti_dict_info))
--log.info(vim.g.current_ulti_dict_info)
print(vim.inspect(vim.g.current_ulti_dict_info))
--log.info(snippetsList)

end

-- function M.resource()
--   require('plenary.reload').reload_module("init")
--   --require("init")
--   vim.cmd([[luafile init.lua]])
--     print('init.lua reloaded')
-- end





function M.saveSnippet()


local visual = vim.api.nvim_exec(
[[
let visual = GetVisualSelection()
echo visual
]], true)
-- print(result)
local snippetKeyword = vim.api.nvim_exec(
        [[
        let keyword = input('Keyword: ')
        echo keyword
        ]], true)

local snippetDescription = vim.api.nvim_exec(
    [[
    let description = input('Description: ')
    echo description
    ]], true)


local outstr = '\n\n' ..'snippet ' .. snippetKeyword .. ' "' .. snippetDescription .. '" b' .. '\n' .. visual .. '\n' .. 'endsnippet'

-- find path to snippet file of current buffer filetype
local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
-- local outfile = 'C:/Users/F1/AppData/Local/nvim-data/testy.snippets'
local outfile = string.format('%s\\%s\\%s.snippets', vim.api.nvim_call_function('stdpath', {'config'}), 'Ultisnips', filetype)
-- print(outfile)

local fp = io.open(outfile, "a")
fp:write(outstr)
fp:close()


end



function M.highlightDebug()
local highlightgroup = vim.api.nvim_eval([[getcompletion('', 'highlight')]])
log1.info(type(highlightgroup))

count = 1
 log1.info('------- NEW RUN -------')
for k, v in pairs(highlightgroup) do
  if count >= 485 and count <= 490 then
  vim.cmd([[highlight clear ]]..v)
    log1.info(v)
    -- put :verbose hi Comment
    -- if not Last Set.. then it hasnt been edited since launch
    --log1.info(count)
  end

  count = count + 1

end

end


function M.checkit()
--log.info(findWindows())
-- local allWindows = vim.api.nvim_list_wins()
vim.api.nvim_set_current_win(1008)
-- for _, winnr in ipairs(allWindows) do
--     local bufnr = vim.fn.winbufnr(winnr)
--     local filetype = vim.fn.getbufvar(bufnr, "&filetype")
--     log.info(filetype)
-- end
end



-- function M.printoutput_onWinEnter()
--     log1.info('printoutput onwinenter trig')
--     log1.info(vim.g.printoutputjump)
-- if vim.g.printoutputjump == true then
--         log1.info('JUMP TRIGERRED')
--         vim.api.nvim_feedkeys('G', 'n', false)
--  vim.g.printoutputjump = false
--     end

 
-- end








return M


