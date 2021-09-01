-- local current_filepath = '/home/f1/.config/nvim/init.lua'
-- local current_filepath = '/home/f1/.config/nvim/lua/futil/session.lua'
-- local current_filepath = '/home/f1/.local/share/nvim/site/pack/packer/opt/telescope.nvim/lua/telescope/command.lua'
local M = {}

local reload = require 'plenary.reload'

function M.resource_init_only()
    require('plenary.reload').reload_module("init")
    -- require("init")
    vim.cmd([[luafile init.lua]])
    print('init.lua reloaded')
end

-- per file reload for lua & vim
function M.resource_single_file()
    -- f: i need to match 'lua' in filepath because you cant pass absolute path to plenary reload, it has to be the required path. this function has to take filepath -> required path
    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local current_filepath = vim.api.nvim_eval('expand("%:p")')
    local current_filename = vim.api.nvim_eval('expand("%:t")')
    lo(current_filepath)
    lo(current_filename)

    if ft == 'lua' and current_filepath ~= string.format('%s/%s', vim.fn.stdpath('config'), 'init.lua') then
        M.resource_lua_file(current_filepath)
        -- print is done in function
    elseif ft == 'lua' and current_filepath == string.format('%s/%s', vim.fn.stdpath('config'), 'init.lua') then
        reload.reload_module('init')
        print('RELOADED LUA: init')
    elseif ft == 'vim' then
        vim.cmd('so %')
        print('RELOADED VIM: ' .. current_filepath)
    end -- if filetype=
end -- endfunction

local function lua_filepath_to_requirepath(current_filepath)
  lo(current_filepath)
    -- breaks on init.lua - dont put through this
    local plugin_filepaths = {
        string.format('%s/%s', vim.fn.stdpath('config'), 'plugins-manual'), string.format('%s/%s', vim.fn.stdpath('config'), 'plugins-me'), string.format('%s/%s', vim.fn.stdpath('data'), 'site/pack/packer/opt'),
        string.format('%s/%s', vim.fn.stdpath('data'), 'site/pack/packer/start'),
        '/home/f1/cl/lua/fork-plug'
    }

    local non_plugin_filepaths = {
      string.format('%s/%s', vim.fn.stdpath('config'), 'lua'),
      '/home/f1/.config/nvim-configs/nvim-main'
    }

    local is_plugin = false
    local filepath_for_sub
    local found_result = false

    for i, plugin_filepath in ipairs(plugin_filepaths) do
        if current_filepath:find(plugin_filepath, 1, true) then
            is_plugin = true
            filepath_for_sub = plugin_filepath
            found_result = true
        end
    end

    -- print(is_plugin)
    -- print(filepath_for_sub)

    if not is_plugin then
        for i, non_plugin_filepath in ipairs(non_plugin_filepaths) do
            if current_filepath:find(non_plugin_filepath, 1, true) then
                is_plugin = false
                filepath_for_sub = non_plugin_filepath
                found_result = true
            end
        end
    end

    if not found_result then print(vim.fn.expand('%'),' filepath not in list of accepted plugin or non plugin filepaths') return end
    -- print(current_filepath)
    -- print(filepath_for_sub)

    if is_plugin == nil or filepath_for_sub == nil then
        print('extractor failed!!')
        return
    end

    local require_path
    local require_path = current_filepath:sub(#filepath_for_sub + 2)

    if is_plugin then
        -- added to extract top level .lua files in plugins 
        _, _, require_path = require_path:find('lua/(.*)')
        if require_path:find('/') then
            _, _, require_path = require_path:find('(.*)/')
        else
            _, _, require_path = require_path:find('(.*)%.')
        end

    else
        require_path = require_path:gsub('%..*$', '')
    end
    return is_plugin, require_path
end

function M.resource_lua_file(current_filepath)
    -- checks whether plugin is in a plugin folder. if not resources, if it is resources whole plugin with plenary

    is_plugin, require_path = lua_filepath_to_requirepath(current_filepath)

    if is_plugin then
        reload.reload_module(require_path, true)
        print('LUA RELOADED: PLUGIN: ' .. require_path)
    else
        print('LUA RELOADED: SINGLE FILE: ' .. require_path)
        reload.reload_module(require_path)
    end

end

-- TESTS: if files arent reload
-- turn on luapad, test return on these 3 files: top level plugin, nested plugin, lua futil etc
-- M.resource_lua_file('/home/f1/.config/nvim/lua/futil/session.lua')
-- M.resource_lua_file('/home/f1/.config/nvim/plugins-me/codelibrary/lua/codelibrary.lua')
-- M.resource_lua_file('/home/f1/.config/nvim/plugins-me/codelibrary/lua/codelibrary/prepare.lua')

return M

-- old
-- reload(filepath)
--           print('lua file plenary reloaded: ' .. filepath)

--   elseif filename == 'init.lua' then
--               reload('init')
--               print('plenary reload: init.lua')
--       else 
--           print('filepath didnt contain lua - did nothing')
--   end --

-- if string.match(filepath,'[\\/?]lua[\\/?]') ~= nil then
--             local filepath = string.match(filepath,'[\\/?]lua[\\/?]([^$]+)%.')
--             print(filepath)

--                     if string.match(filepath, '\\') ~= nil then
--                    local filepath = string.gsub(filepath,'\\','/')
--                         end 

