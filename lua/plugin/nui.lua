local nui = {}
local log = require'log1'
local Popup = require("nui.popup")


nui.manager = {}


local function execute_actions(self, opts)

log.info('execute actions called')
opts.bufnr = self.bufnr

vim.api.nvim_buf_call(self.bufnr, function() nui.actions[opts.action](opts) end)
end


nui.new = function(opts)


  local choose = {
    main = {
  border = {
    style = "rounded",
    highlight = "FloatBorder",
    text = { top = string.format('send_to_old', opts.filepath), top_align = 'center' }
  },
  position = {row = "100%", col = "50%"},
  size = {
    width = "50%",
    height = "20%",
  },
  opacity = 1,
}
}



nui.manager[opts.name] = Popup(choose[opts.name])

nui.manager[opts.name].execute_actions = execute_actions

end


nui.open = function(opts)
if nui.manager[opts.name] then 
  if opts.action then nui.manager[opts.name]:execute_actions(opts) end
  log.info('config already exists, executing actions')
else
nui.new(opts)
nui.mount(opts)
if opts.action then nui.manager[opts.name]:execute_actions(opts) end
--log.info(nui.manager)
end
end

nui.mount = function(opts)
nui.manager[opts.name]:mount()
end


nui.unmount = function(opts)
nui.manager[opts.name]:unmount()
nui.manager[opts.name] = nil
end

nui.close_all_windows = function()
for name, opts in pairs(nui.manager) do
  nui.manager[name]:unmount()
  nui.manager[name] = nil

end
end


nui.actions = {

open_file = function(opts) 
 

   if not opts.filepath then
                vim.api.nvim_buf_set_lines(opts.bufnr, 0, -1, false, { 'Error: filepath not specified' })
                return
            end
   


    -- dont do anything if buffer already contains the file
    local cfp = vim.fn.expand('%')
    if cfp == opts.filepath then 
      log.info('open file: buffer already contains file')  
      else

            -- if buffer already exists in neovim but not in window
            for k, bufnr in pairs(vim.api.nvim_list_bufs()) do
                local iter_name = vim.api.nvim_buf_get_name(bufnr)
                if iter_name == filepath then
                    vim.api.nvim_buf_set_option(bufnr, 'buflisted', true)
                    vim.api.nvim_win_set_buf(opts.winnr, bufnr)
                    opts.bufnr = bufnr
                end
            end

            vim.api.nvim_buf_set_name(opts.bufnr, opts.filepath)
            vim.api.nvim_buf_set_option(opts.bufnr, 'buftype', '')
          end
                 log.info('open file: e! trig!!')
 vim.schedule(function() vim.api.nvim_buf_call(opts.bufnr, function() vim.cmd([[edit!]]) end) end)

    vim.cmd('e!')
          end, 



}

return nui
