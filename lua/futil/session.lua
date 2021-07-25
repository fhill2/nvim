local M = {}

local mksession_filename = 'nvim' .. vim.v.servername:match('%d') .. '.vim'
local mksession_filepath = string.format('%s/lua/futil/state/%s', vim.fn.stdpath('config'), mksession_filename)


 -- States - fstate & luapad
local fstate_filepath = string.format('%s/lua/futil/state/fstate%s.lua', vim.fn.stdpath('config'), vim.v.servername:match('%d'))
local fstate_requirepath = string.format('futil/state/fstate%s', vim.v.servername:match('%d')) -- futil/state/tempstate1.lua as string


function M.saveSession(servername)
 -- M.session_load_post_retrigger = true
  -- lo(vim.v.servername .. ': SAVE session trig')

  local mksession_filename = 'nvim' .. vim.v.servername:match('%d') .. '.vim'

  vim.cmd(string.format('mksession! %s', mksession_filepath))
--lo(mksession_filepath)

-- save fstate
-- local fp = io.open(fstate_filepath, "w")
-- if pcall(require, 'livetablelogger') == true then
-- fp:write('return ' .. tostring(fstate))
-- else
-- fp:write('return ' .. vim.inspect(fstate))

-- end
-- fp:close()


end


-- DONT NEED THIS, i just added set global variable in nvim tree codebase
function M.nvimtree_root_from_buffer()
  local allWindows = vim.api.nvim_list_wins()

  for _, winnr in pairs(allWindows) do
    local bufnr = vim.fn.winbufnr(winnr)

    if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'NvimTree' then
      -- lo(vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)[1]:gsub('/..$', ''))
      return vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)[1]:gsub('/..$', ''):gsub('^%~', '/home/f1')

    end
  end
end

-- TODO: attach luapad to btmwindow on save. and maybe all windows that had luapad attached. but wait until codi.vim

function M.restoreSession()
--if mksession_filename == 'nvim2.vim' then  lo(string.format('%s RESTORE session trig', mksession_filename)) end
   -- REMOVE silent to view mksession errors


if io.open(string.format('%s/lua/futil/state/%s', vim.fn.stdpath('config'), mksession_filename), 'r') ~= nil then
--if mksession_filename == 'nvim1.vim' then lo('SESSION file exists - loading session') end
 vim.cmd(string.format([[execute 'silent source %s/lua/futil/state/%s']], vim.fn.stdpath('config'), mksession_filename))

-- LOAD States - fstate & luapad

--package.loaded needed only if reading last session state without reloading nvim, for future proof
if package.loaded[fstate_requirepath] ~= nil then package.loaded[fstate_requirepath] = nil end
fstate = require(fstate_requirepath)




-- load luapad onto previous active luapad buffers before session
if vim.tbl_isempty(fstate.luapad.filenames) == false then
for _, current_luapad_filename in ipairs(fstate.luapad.filenames) do

--print('asd')
for k, v in ipairs(vim.api.nvim_list_bufs()) do
  vname = vim.api.nvim_buf_get_name(v)
    if current_luapad_filename == vname then
      require('luapad/evaluator'):new { buf = v }:start()
    end
end
-- set eval_on_change to whatever the current window is
require'plugin/luapad'.onWinEnter()
end


end



  if fstate.nvimtree_cwd ~= nil then

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(bufnr):match('NvimTree$') == 'NvimTree' then
             vim.api.nvim_buf_delete(bufnr, {force = true})
      end
    end

    vim.defer_fn(function()

     
      vim.cmd([[NvimTreeClose]])
      vim.wait(100)
      require'nvim-tree'.on_keypress('cdtree', fstate.nvimtree_cwd)
    end, 10)
  end -- end of nvim tree = nil


end -- END ONLY IF SESSION FILE EXISTS


  -- Saved session trigerred by timer
  local timer = vim.loop.new_timer()
  timer:start(3000, 5000, vim.schedule_wrap(function()
    M.saveSession()
    -- lo('timer trigerred')

  end))
end

function M.close_all_nonsaved_buffers()
  local allBuf = vim.api.nvim_list_bufs()
  local allWin = vim.api.nvim_list_wins()

  for _, bufnr in ipairs(allBuf) do vim.api.nvim_buf_call(bufnr, function() if vim.bo.modified == true then vim.cmd([[w]]) end end) end

  for _, bufnr in ipairs(allBuf) do vim.api.nvim_buf_delete(bufnr, {}) end

  vim.api.nvim_set_current_dir('/home/f1/.config/nvim')
end

function M.delete_all_temp_sessions()

end

function M.delete_current_temp_session()
end


return M

--- add to old
--local luapad_filename = 'luapadstate' .. vim.v.servername:match('%d') .. '.lua'
--local luapad_filepath = string.format('%s/lua/futil/state/%s', vim.fn.stdpath('config'), luapad_filename)
--local luapad_requirepath = string.format('futil/state/luapadstate%s', vim.v.servername:match('%d'))


   -- below makes cursor jump / mouse cursor jump to btm fast
  -- vim.cmd(string.format([[execute 'silent !sudo rm /tmp/%s']], mksession_filename))

-- if mksession_filename == 'nvim2.vim' then lo(string.format('%s SAVE session', mksession_filename)) end







-- save luapad stated
-- local fp = io.open(luapad_filepath, "w")
-- fp:write('return ' .. vim.inspect(State))
-- fp:close()




 -- vim.g.State.nvimtree.cwd = M.nvimtree_root_from_buffer()
  -- -- write nvim tree cwd so I can manually open it on session restore
  -- local nvimtree_root = M.nvimtree_root_from_buffer()
  -- --  lo('got here22')
  -- -- lo(nvimtree_root)
  -- if nvimtree_root == nil then nvimtree_root = 'nil' end

  -- local nvimtree_filename = 'nvimtree' .. vim.v.servername:match('%d') .. '.vim'
  -- local fp = io.open('/tmp/' .. nvimtree_filename, "w")
  -- fp:write(nvimtree_root)
  -- fp:close()




-- lo(vim.g.State)
-- local result = vim.api.nvim_exec(string.format([[
-- source /tmp/%s'
-- ]], mksession_filename), false)





--if mksession_filename == 'nvim2.vim' then
--lo('State after loaded from session')
--lo(fstate)
--end




--State = vim.g.State
--print(result)
--lo(vim.v.errmsg)


-- transfer vim.g.State to State global
-- cant use v:errmsg here, but can check if session file exists. if not dont set vim.g.State -> State
--lo('restore SESSION')
--lo(State.nvimtree_cwd)
  -- if nvim tree existed, load nvim
  -- tried it on sessionloadpost autocmd but kept trigerring 4 times for 1 load, 
  -- local nvimtree_root = vim.fn.readfile('/tmp/nvimtree' .. vim.v.servername:match('%d') .. '.vim')[1]








-- for _, v in ipairs(fstate.luapad.all_luapad_bufnr) do
--   lo('all_luapad_bufnr is')
--   lo(all_luapad_bufnr)
-- vim.api.nvim_buf_call(v, function()
--   lo('all_luapad_bufnr called: ')
--    require'luapad'.attach()  
-- end)











-- function M.testit()

--   --  local nvimtree_root = vim.fn.readfile('/tmp/nvimtree' .. vim.v.servername:match('%d') .. '.vim')[1]
--   local nvimtree_root = '/home/f1/.dotfiles'
--   if nvimtree_root ~= nil then
--     -- lo('sessionload nvimtree_root is:')
--     -- lo(nvimtree_root)

--     for _, winnr in pairs(vim.api.nvim_list_wins()) do
--       local bufnr = vim.fn.winbufnr(winnr)
--       if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'NvimTree' then vim.api.nvim_buf_delete(bufnr, {force = true}) end
--     end
--     require'nvim-tree'.on_keypress('cdtree', nvimtree_root)
--   end
-- end



-- oldest


-- M.session_load_post_retrigger = false

-- function M.onSessionLoadPost()
-- lo('SessionLoadPost autocmd trig!!')
-- manual restore post session - this fires a lot of times dont know why
-- if M.session_load_post_retrigger == false then return end
-- M.session_load_post_retrigger = false

-- then loop through windows to target manually other stuff to do
-- read nvimtree1.vim here into variable
-- lo(vim.api.nvim_buf_get_option(bufnr, 'filetype'))
-- if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'NvimTree' then
--   vim.api.nvim_buf_delete(bufnr, {force = true})
--   vim.api.nvim_win_close(winnr, true)

-- end

-- end
-- print(vim.api.nvim_get_option('titlestring'))

-- vim.defer_fn(function()
--   -- print('defer fn ran')
--   if vim.v.servername == "/tmp/nvim1" then
--     --  print('servername is nvim1')
--     vim.cmd(
--       [[!/mnt/c/Program\ Files/AutoHotkey/AutoHotkey.exe c:/Users/F1/scripts/ahk/AAMain/winpos/neovide1.ahk]])
--   elseif vim.v.servername == "/tmp/nvim2" then
--     --  print('servername is nvim2')
--     vim.cmd(
--       [[execute 'silent !/mnt/c/Program\ Files/AutoHotkey/AutoHotkey.exe c:/Users/F1/scripts/ahk/AAMain/winpos/neovide2.ahk']])
--   end
-- end, 1)
-- for _, winnr in pairs(vim.api.nvim_list_wins()) do

--   local bufnr = vim.fn.winbufnr(winnr)
--   if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'NvimTree' then
--     lo('buffer deleted')
--     vim.api.nvim_buf_delete(bufnr, {force = true})
--   end
-- end

-- function M.onSessionLoadPost()
--   lo('SessionLoadPost autocmd trig!!')
--   -- manual restore post session - this fires a lot of times dont know why
--   if M.session_load_post_retrigger == false then return end

--   local allWindows = vim.api.nvim_list_wins()

--   for _, winnr in pairs(allWindows) do
--     local bufnr = vim.fn.winbufnr(winnr)
--     -- read nvimtree1.vim here into variable
--     lo(vim.api.nvim_buf_get_option(bufnr, 'filetype'))
--     if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'NvimTree' then
--       vim.api.nvim_buf_delete(bufnr, {force = true})
--       vim.api.nvim_win_close(winnr, true)
--       local nvimtree_root = vim.fn.readfile(
--                               '/tmp/nvimtree' .. vim.v.servername:match('%d') .. '.vim')[1]
--       lo('sessionload nvimtree_root is:')
--       lo(nvimtree_root)
--       require'nvim-tree'.on_keypress('cdtree', nvimtree_root)

--     end

--   end

--   M.session_load_post_retrigger = false

-- end
