local M = {}
local api = vim.api
-- local log3 = require('log3')

local path_to_luapad = vim.fn.stdpath('config') .. '/lua/luapad/luapad.lua'


--local window = require 'futil/window'


 
function M.getBtmWindowCount()
  local count = 0

  for k, v in pairs(fstate.btmwindow) do   
for k, v in pairs(v) do
if k == 'winnr' and v ~= nil then count = count + 1 end
end end

  -- for _, v in pairs(State.btmwindow) do
  --   for _, v in pairs(v) do
  --   if v['winnr'] ~= nil then count = count + 1  
  --   end end end

  return count



end

function M.get_btm_winnr_from_pos(position)


  for j, l in pairs(fstate.btmwindow) do   
for k, v in pairs(l) do
if k == 'position' and v == position then return l['winnr'] end
end end

  -- -- input position, return winnr 
  -- for _, v in pairs(State.btmwindow) do
  --   for _, v in pairs(v) do
  --   if v['position'] == position then return v['winnr'] end 
  -- end 
end




function M.toggleBtmWindow()

  -- local btmstate = M.findBtmstate()
  --
  local btmcount = M.getBtmWindowCount()
  -- log3.info('PREVSTATE AT START IS:')
  -- log3.info(prevstate)

  if prevstate == nil then
    -- log3.info(M.btmstate)
    prevstate = vim.deepcopy(fstate.btmwindow)


    -- log3.info('PREVSTATE IN IF: ')
    -- log3.info(prevstate)
  end

  if btmcount > 0 then

    -- shut all windows
    for k, v in pairs(fstate.btmwindow) do M.close_btm_win_single(k) end

  else
    -- log3.info('PREVSTATE IS: ')
    -- log3.info(prevstate)
    local recreate = {}
    for k, v in pairs(prevstate) do

      if v['position'] ~= nil then
        local key = v['position']
        recreate[key] = k
      end
    end
    for _, v in pairs(recreate) do M.toggle_btm_win_single(v) end

    prevstate = nil

  end -- end if btmcount

end

function M.close_btm_win_single(action)
  --  log3.info('close trig')

  local cwinnr = fstate.btmwindow[action]['winnr']
  -- log3.info(cwinnr)
  -- log3.info(action)
  vim.F.npcall(api.nvim_win_close, cwinnr, true)
  fstate.btmwindow[action]['winnr'] = nil
  fstate.btmwindow[action]['position'] = nil
  M.refresh_btm_state()
end

function M.toggle_btm_win_single(action)

  if fstate.btmwindow[action]['winnr'] ~= nil then
    M.close_btm_win_single(action)
    return
  end

  -- local btmstate = M.findBtmstate()
  local btmcount = M.getBtmWindowCount()

  if btmcount > 0 then api.nvim_set_current_win(M.get_btm_winnr_from_pos(btmcount)) end


  M.loadBuffer(action)

  if btmcount == 0 then
    vim.cmd([[botright sb]] .. fstate.btmwindow[action]['bufnr'])
    vim.cmd([[resize 12]])
  elseif btmcount > 0 then
    vim.cmd([[vert sb ]] .. fstate.btmwindow[action]['bufnr'])
  end

  --api.nvim_win_set_var(0, action, true) -- needed for refresh btm state
  --api.nvim_win_set_var(0, 'btmwindow', true)


  fstate.btmwindow[action]['winnr'] = api.nvim_get_current_win()
  fstate.btmwindow[action]['position'] = btmcount + 1
  fstate.btmwindow_exists = true

  -- log3.info(M.btmstate)

  -- M.refresh_btm_state()
--  lo(fstate)
end


local function get_all_buf_name()

end



function M.loadBuffer(action)
fstate.btmwindow[action]['bufnr'] = vim.api.nvim_create_buf(true, false)
local cbuf = fstate.btmwindow[action]['bufnr'] 


--lo(action)

   if action == 'luapad' then

--vim.api.nvim_buf_set_name(cbuf, path_to_luapad)     
-- vim.api.nvim_buf_set_lines(cbuf, 0, -1, true, vim.fn.readfile(path_to_luapad))
 

 vim.api.nvim_buf_call(cbuf, function(action) 
 --  lo(path_to_luapad)
   vim.cmd(string.format(":e %s", path_to_luapad)) 
     -- attach luapad
local luapad = require('luapad')
   luapad.config {eval_on_change = fstate.luapad.btmwindow_eval_on_change}
   luapad.attach()   
--   lo('BTMWINDOW luapad window created')
 end)
     elseif action == 'fterminal' then

 vim.api.nvim_buf_call(cbuf, function(action) 
    vim.cmd('terminal')
    vim.bo.filetype = 'terminal'
  end)
   -- vim.b.btmwindow = 'fterminal'
  elseif action == 'quickfix' then
   -- vim.b.btmwindow = 'quickfix'
   -- print('asd')
  end


end

function M.onWinClosed()
  M.refresh_btm_state()
  -- remember autocmd is before? even tho docs says after???
end

function M.refresh_btm_state()
--lo('refresh_btm_state trig')
  local current_bufnr = vim.api.nvim_get_current_buf()

if current_bufnr == fstate.btmwindow.luapad.bufnr then
vim.api.nvim_buf_call(fstate.btmwindow.luapad.bufnr, function() vim.cmd([[w]]) end)
vim.api.nvim_buf_delete(fstate.btmwindow.luapad.bufnr, { force = true,  unload = false })
elseif current_bufnr == fstate.btmwindow.fterminal.bufnr then
vim.api.nvim_buf_delete(fstate.btmwindow.fterminal.bufnr, { force = true,  unload = false })


end


-- was the bufnr I closed a btmwindow buffer/window
  for j, l in pairs(fstate.btmwindow) do   
for k, v in pairs(l) do
if k == 'bufnr' and v == current_bufnr then 
fstate.btmwindow[j] = {}
end

end 

--lo(State)
end


--lo(State)


  -- local allWindows = vim.api.nvim_list_wins()
  -- local npcall = vim.F.npcall

  -- if npcall(vim.api.nvim_win_get_var, 0, 'luapad') == true then
  --   State.btmwindow['luapad']['winnr'] = nil
  --   State.btmwindow['luapad']['position'] = nil
  -- end

  -- if npcall(vim.api.nvim_win_get_var, 0, 'fterminal') == true then
  --   State.btmwindow['fterminal']['winnr'] = nil
  --   State.btmwindow['fterminal']['position'] = nil
  -- end

  -- if npcall(vim.api.nvim_win_get_var, 0, 'quickfix') == true then
  --   State.btmwindow['quickfix']['winnr'] = nil
  --   State.btmwindow['quickfix']['position'] = nil
  -- end

  -- if State.btmwindow.luapad.winnr == nil and State.btmwindow.fterminal.winnr == nil and State.btmwindow.quickfix.winnr == nil then State.btmwindow_exists = false end

  -- log3.info(M.btmstate)

end

return M


--- old



--- OLd refresh btm state
-- function M.refresh_btm_state()

--   local allWindows = vim.api.nvim_list_wins()
--   local npcall = vim.F.npcall

--   if npcall(vim.api.nvim_win_get_var, 0, 'luapad') == true then
--     State.btmwindow['luapad']['winnr'] = nil
--     State.btmwindow['luapad']['position'] = nil
--   end

--   if npcall(vim.api.nvim_win_get_var, 0, 'fterminal') == true then
--     State.btmwindow['fterminal']['winnr'] = nil
--     State.btmwindow['fterminal']['position'] = nil
--   end

--   if npcall(vim.api.nvim_win_get_var, 0, 'quickfix') == true then
--     State.btmwindow['quickfix']['winnr'] = nil
--     State.btmwindow['quickfix']['position'] = nil
--   end

--   if State.btmwindow.luapad.winnr == nil and State.btmwindow.fterminal.winnr == nil and State.btmwindow.quickfix.winnr == nil then State.btmwindow_exists = false end

--   -- log3.info(M.btmstate)

-- end

  -- log3.info(btmcount)

  -- if btmstate['fterminal'] == nil and btmstate['quickfix'] == nil and btmstate['luapad'] == nil then
  -- table.insert(window.State.excluded, vim.api.nvim_get_current_win())
  -- l('from btmwindow set: winnr is')
  -- l(vim.api.nvim_get_current_win())
  -- for terminal: -- exec "buffer " . term
  -- api.nvim_win_set_var(0, action, true)
  -- api.nvim_win_set_var(0, 'btmwindow', true)

  -- l(window.State)
  -- M.btmstate[action]['winnr'] = api.nvim_get_current_win()
  -- M.btmstate[action]['position'] = btmcount + 1 
  -- log3.info(M.btmstate)
  -- M.loadBuffer(action)
  -- require'keymap/luapad'.onWinEnter()

  -- log3.info('this trigerred')
  -- log3.info(M.get_btm_winnr_from_pos(btmcount))
  -- log3.info(api.nvim_get_current_win())
  -- vim.cmd([[execute "wincmd" "l"]])
  -- table.insert(window.State.excluded, vim.api.nvim_get_current_win())

  -- l('from btmwindow set: winnr is')
  -- l(vim.api.nvim_get_current_win())
  -- l(window.State)

-- log3.info(M.btmstate)

-- end

-- function M.setbtmstate()
-- M.btmstate['fterminal']['winnr'] = api.nvim_get_current_win()
-- log3.info(api.nvim_get_current_win())
-- log3.info(M.btmstate)
-- end 


