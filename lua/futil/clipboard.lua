local M = {}

function M.onTextYankPost()
lo('onTextYankPost trig')
--lo(vim.v.event)
local clip = vim.v.event.regcontents[1]
lo(clip)


end


--function M.ctrl_c_buf()
-- wrap ctrl c because it doesnt trigger onTextYankPost autocmd event
-- vim.api.nvim_feedkeys('i', 'n', false)


--end 


function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
      local s = assert(f:read('*a'))
        f:close()
          if raw then return s end
            -- strips leading whitespace
            s = string.gsub(s, '^%s+', '')
            -- strips trailing whitespace
              s = string.gsub(s, '%s+$', '')
              -- convert win line endings to unix line endings
                s = string.gsub(s, '[\n\r]+', '\n')
                  return s
                end


local function read_file(filepath)
  local fd = vim.loop.fs_open(filepath, "r", 438)
  if fd == nil then return '' end
  local stat = assert(vim.loop.fs_fstat(fd))
  if stat.type ~= 'file' then return '' end
  local data = assert(vim.loop.fs_read(fd, stat.size, 0))
  assert(vim.loop.fs_close(fd))
  return data
end



-- this is triggered by nvr on windows side when using ctrl+c on any window apart from ahk_exe neovide and maybe alacritty 
function M.read_win_clipboard()
l('read_win_clipboard trigerred')
vim.g.clipboard = os.capture([[/mnt/c/Users/f1/scripts/ahk/AAMain/win32yank.exe -o --lf]])
--lo(clip)
--local clip = io.open('/mnt/c/Users/F1/scripts/ahk/AAMain/clip.txt', 'r')
--local clipboard =  = read_file('/mnt/c/Users/F1/scripts/ahk/AAMain/clip.txt')
--clipboard:gsub('\r\n', '\n')
--vim.g.clipboard = clipboard
vim.cmd([[let @" = g:clipboard]])
--l(vim.g.clipboard)

end

return M



