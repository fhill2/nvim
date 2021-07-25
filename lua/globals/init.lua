local printoutput = require'futil/printoutput'
local log = require'log1'




local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end


RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

p = function(v)
  print(vim.inspect(v))
  return v
end


pr = function(msg)
    printoutput.pr(msg)
end

-- po = function(msg)
--     printoutput.po(msg)
-- end

lo = function(msg)
log.info(msg)
return msg
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end


--ltl = require'livetablelogger'.log

--ftest = ltl('test', {})





-- fstate = ltl({a=1, b=2})



-- lo('======= NEW RUN ======')

-- --
-- local t = ltl({a=1, b=5})


-- function t:new()
--   local timer = vim.loop.new_timer()

--   timer:start(1, 500, vim.schedule_wrap(function()
--     lo('callback')
--     t.e = 'asd'
--                print('qwertyasdsdsdsd')

--             t.e = math.randomseed(os.time()) 
--     --      vim.api.nvim_command('echomsg "test"')
--   end))

--         lo('orig function :new ran')
-- end

-- function t:newadon()
-- lo('another new functoin yes it is')
-- end


-- t.f = {key = 'some more keys here', key2 = { 'another key' } }







   -- local function on_change(err, fname, status)
   --    -- Do work...
   --    lo('on change trig')
   --    vim.api.nvim_command('checktime')
   --    -- Debounce: stop/start.
   --    w:stop()
   --    watch_file(fname)
   --  end

-- w = vim.loop.new_fs_event()


--     function watch_file(fname)
--       lo('watch file trig')
--       local fullpath = vim.api.nvim_call_function(
--         'fnamemodify', {fname, ':p'})

--       w:start('/home/f1/.config/nvim/lua/asd11.lua', {}, vim.schedule_wrap(function(...)
--         on_change(...) end))
--         lo(fullpath)
--     end




 --- test tables

--test1 = { key1 = 'key1', key2 = 'key2' }
--test2 = { key3 = 'key3', key4 = 'key4' }



-- f: couldnt get ipairs working for fstate2
-- local function oipairs (a, i)
--       i = i + 1
--       local v = a[i]
--       if v then
--         return i, v
--       end
--     end

-- function ipairs(t)
-- -- 1st get table size
-- local count = 0
-- for _, __ in next, t, nil do 
--     count = count + 1
--   end
-- -- 2nd if table size is 1 check if name of key is proxy and value is table
-- if count == 1 then 


-- if t['proxy'] ~= nil then 
--   for _, v in next, t, nil do
--       if type(v) == 'table' then 
--         lo('proxy table returned') 
--         return oipairs(t), t, 0
--       end
--   end
-- end

-- end
-- return oipairs(t), t, 0
-- end




-- function iter (a, i)
--       i = i + 1
--       local v = a[i]
--       if v thend
--         return i, v
--       end
--     end
    

-- function ipairs (a)
--       return iter, a, 0
--     end


-- function pairs(t)
-- if vim.tbl_isempty(t) then 
--   lo('tbl is empty pairs') return next, t, nil end
-- return next, t, nil
-- end




-- function pairs(t)
-- -- 1st get table size
-- local count = 0
-- for _, __ in next, t, nil do 
--     count = count + 1
--   end
-- -- 2nd if table size is 1 check if name of key is proxy and value is table
-- if count == 1 then 


-- if t['proxy'] ~= nil then 
--   for _, v in next, t, nil do
--       if type(v) == 'table' then 
--        -- lo('proxy table returned') 
--         return next, t['proxy'], nil 
--       end
--   end
-- end

-- end
-- return next, t, nil
-- end





-- fstate = { 
--                window = { included = {}, excluded = {}, current_winnr = nil}, 
--         nvimtree_cwd = nil,
--         btmwindow = {
--         luapad = {winnr = nil, bufnr = nil, position = nil}, 
--         fterminal = {winnr = nil, bufnr = nil, position = nil}, 
--         quickfix = {winnr = nil, bufnr = nil, position = nil},
--         },
--         btmwindow_exists = false,
--         luapad = { 
--           filenames = {},
--           editor_eval_on_change = false,
--           btmwindow_eval_on_change = true,
--           },
--           telescope = {
--           results = { bufnr = false },
--           preview = { bufnr = false },
--           test = 0,
--             uipreset = {
--             list = { 'height50'},
--             active = 'height50'
--           }
--         },
--  log = { 
--   mode = 'whitelist', -- whitelist/off/all -- all will bypass filter
--   whitelist = { 'fstate2.luapad', 'another entry', 'another45' }
-- }
-- }




-- full static state for debug
-- State = { 
--         window = { included = { 1010, 1011}, excluded = { 1012, 1013}, current_winnr = 1000}, 
--         nvimtree_cwd = '/home/f1/.dotfiles',
--         btmwindow = {
--         luapad = {winnr = 1001, bufnr = 1002, position = 1}, 
--         fterminal = {winnr = 1003, bufnr = 1004, position = 2}, 
--         quickfix = {winnr = 1005, bufnr = 1006, position = 3},
--         exists = false }
--         }


--require('tj.globals.opt')






-- old



-- WRAPPERS for pairs and ipairs for fstate proxy + metamethod logging

-- local function origpairs(t)
-- return next, t, nil
-- end

-- local function getTableSize(t)
--     local count = 0
--     for _, __ in origpairs(t) do
--         count = count + 1
--     end
--     return count
-- end

-- function print(...)

-- end

