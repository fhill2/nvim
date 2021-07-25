local send = {}

local log = require'log1'

local uv = vim.loop
local open_mode = uv.constants.O_CREAT + uv.constants.O_WRONLY + uv.constants.O_TRUNC
local utils = require 'futil/utils'
local actions = require'omnimenu/actions'
--local manager = require'floating/manager'
local nui = require'plugin/nui'

local accepted_filepaths = {
    string.format('%s/%s', vim.fn.stdpath('config'), 'lua'), 
    string.format('%s/%s', vim.fn.stdpath('config'), 'plugins-me'),
   string.format('%s/%s', vim.fn.stdpath('config'), 'plugins-manual'),
}

local dest_root = '/home/f1/cl/old'





  local function create_file(file)
        uv.fs_open(file, "w", open_mode, vim.schedule_wrap(function(err, fd)
            if err then
                vim.api.nvim_err_writeln('Could not create file ' .. file)
            else
                -- FIXME: i don't know why but libuv keeps creating file with executable permissions
                -- this is why we need to chmod to default file permissions
                uv.fs_chmod(file, 420)
                uv.fs_close(fd)
            end
        end))
    end


send.prepare_filepath = function()
  
    -- check if filepath of current buffer is in list of filepaths that i want to send_to_old to
    local current_filepath = vim.api.nvim_buf_get_name(0)

    
         local should_continue = false
    local accepted_index, accepted_filepath
    for i, fp in ipairs(accepted_filepaths) do
        if current_filepath:find(fp, 1, true) then
            should_continue = true
            accepted_index = i
            accepted_filepath = fp
        end
    end
   -- create send_to_old destination filepath from source
    local dest_filepath


-- old_filepath = output path, sent to libuv


if accepted_filepath ~= nil then

  if accepted_index == 2 or accepted_index == 3 then
    if accepted_index == 2 then 
        local _, _, dest_relpath = current_filepath:find('/plugins%-me/(.*)$')
    dest_filepath = string.format('%s/lua/plugins-me/%s', dest_root, dest_relpath)
    end

    if accepted_index == 3 then 
      local _, _, dest_relpath = current_filepath:find('/plugins%-manual/(.*)$')
 dest_filepath = string.format('%s/lua/plugins-manual/%s', dest_root, dest_relpath)
    end


 
    elseif accepted_index == 1 then
        local _, _, dest_relpath = current_filepath:find('/lua/(.*)')
              dest_filepath = string.format('%s/lua/config/%s', dest_root, dest_relpath)
         end




elseif accepted_filepath == nil then
local _, _, dest_relpath = current_filepath:find('.*/(.*)')
  dest_filepath = string.format('%s/shell/%s', dest_root, dest_relpath)
end




  return dest_filepath

end



send.create_file_and_folders = function(dest_filepath)
-- UNCOMMENTED BELOW HERE
 local old_file_exists = uv.fs_stat(dest_filepath, nil)


    -- check if file already exists
       if old_file_exists == nil then
    -- IF NOT, create file and make sure all directories are created and exist
                utils.create_fp_dirs(dest_filepath)
       create_file(dest_filepath)
     end


end

send.create_dest = function()
  local dest_filepath = send.prepare_filepath() 
    send.create_file_and_folders(dest_filepath)
    return dest_filepath
end


send.send_visual = function()
-- sends visual selection to code library
   local visual = vim.api.nvim_call_function('GetVisualSelection', {})
  vim.api.nvim_feedkeys('dd', 'n', true)
    local dest_filepath = send.prepare_filepath() 
    send.create_file_and_folders(dest_filepath)
utils.append_to_file(dest_filepath, visual)

vim.defer_fn(function()

nui.open({ name = 'main', action = 'open_file', filepath = dest_filepath})

     end, 50)
  
return dest_filepath

  end


return send




