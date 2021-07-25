local utils = {}

local uv = vim.loop


-- for require path to filepath
  local config = {}
  config.opt_dir = '/home/f1/.local/share/nvim/site/pack/packer/opt'
  config.start_dir = '/home/f1/.local/share/nvim/site/pack/packer/start'
  config.lua_dir = string.format('%s/%s', vim.fn.stdpath('config'), 'lua')



utils.repeated_table = function(n, val)
    local empty_lines = {}
    for _ = 1, n do table.insert(empty_lines, val) end
    return empty_lines
end

-- check if all folders in a filepath exist. if not, create them
-- only works for folders in current user folder
utils.create_fp_dirs = function(fp)
local home = uv.os_homedir()

if fp:find(home) then 
  _, _, fp = fp:find(home .. '/(.*)')
end

local dirs_to_create = {}

    local fp = vim.split(fp, '/')
    local file_or_dir = fp[#fp]:find('%.')
    if file_or_dir then table.remove(fp, #fp) end
    local depth = #fp
    local current_relpath = fp[1]
    for i = 1, depth do
        table.insert(dirs_to_create, string.format('%s/%s', home, current_relpath))
        current_relpath = current_relpath .. '/' .. (fp[i + 1] or '')
    end

      for i, folderpath in ipairs(dirs_to_create) do
        local fp = string.format('%s/%s', home, fp)

        local mode = uv.fs_stat(home).mode

        local r = uv.fs_stat(folderpath, nil)
        if r == nil then
           local r = uv.fs_mkdir(folderpath, mode, nil)
           if r == nil then assert(false, 'couldnt write to file ' .. folderpath) end
        end
    end
  end

local function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then return i, t[i] end
end

utils.reversed_ipairs = function(t) return reversedipairsiter, t, #t + 1 end

utils.append_to_file = function(filepath, msg)
    -- this rewrites the whole file again, it doesnt incremental write

    -- read data 
    local fd = vim.loop.fs_open(filepath, "r", 438)
    if fd == nil then return '' end
    local stat = assert(vim.loop.fs_fstat(fd))
    if stat.type ~= 'file' then return '' end
    local data = assert(vim.loop.fs_read(fd, stat.size, 0))
    assert(vim.loop.fs_close(fd))

    -- combine orig data and new data
    if type(msg) == 'string' then
        data = msg .. '\n' .. data
    elseif type(msg) == 'table' then
        for i, str in ipairs(msg) do data = str .. '\n' .. data end
    end
    local msg = '\n' .. data .. '\n'
    lo(msg)

    -- write to same file
    local fdp = uv.fs_open(filepath, "w", 438)

    uv.fs_write(fdp, msg, nil, function()
        lo('old_filepath written')
        uv.fs_close(fdp)
    end)

end


utils.remove_socket = function(filepath)
  lo('REMOVE SOCKET TRIG')
-- validate filepath first make sure im deleting inside tmp folder
if filepath:find('^%/tmp/') ~= nil then
--local _, _, file = filepath:find('/tmp/(.*)')

-- check if file exists and is a socket
is_socket = uv.fs_stat(filepath).type
if is_socket == 'socket' then 
uv.fs_unlink(filepath)
end

end



end


utils.list_all_plugins = function() 
  local opt_plugins = {}
  local start_plugins = {}


  for _, path in ipairs(vim.fn.globpath(config.opt_dir, '*', true, true)) do
local dir_or_sym = uv.fs_lstat(path).type
if dir_or_sym == 'link' then path = uv.fs_realpath(path) end

_, _, opt_root = path:find('.*/(.*)')
opt_root = opt_root:gsub('%..*$', '')

    opt_plugins[path] = opt_root
  end

  for _, path in ipairs(vim.fn.globpath(config.start_dir, '*', true, true)) do
local dir_or_sym = uv.fs_lstat(path).type
if dir_or_sym == 'link' then path = uv.fs_realpath(path) end

_, _, start_root = path:find('.*/(.*)')
start_root = start_root:gsub('%..*$', '')

    start_plugins[path] = start_root
  end

local all_plugins = {}
local all_plugins = vim.tbl_extend('keep', opt_plugins, start_plugins)
 return all_plugins

end

utils.req_to_fp = function(input)
assert(input, 'no require path input passed in')
  -- manual config here because cba to try to read packer config




local all_plugins = utils.list_all_plugins()

 
_, _, match = input:find('(.*)/.*')
local is_plugin = false
local filepath_root
  for path, root in pairs(all_plugins) do
    if match == root then 
      is_plugin = true 
      filepath_root = path
    end 

  end

  if is_plugin then
  return string.format('%s/lua/%s.lua', filepath_root, input)
  else
  return string.format('%s/%s.lua', config.lua_dir, input)
  end


end


--for galaxyline
utils.is_buffer_empty = function()
  -- Check whether the current buffer is empty
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

utils.has_width_gt = function(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end


utils.get_filename = function(filepath)
      return filepath:match("^.+/(.+)$")
end


return utils



