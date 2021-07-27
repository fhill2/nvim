local nui = {}
local log = require'log1'
local Popup = require("nui.popup")



-- asdasd
-- this
-- is a multi
-- line

nui.manager = {}


local function execute_actions(self, opts)

log.info('execute actions called')
opts.bufnr = self.bufnr

vim.api.nvim_buf_call(self.bufnr, function() nui.actions[opts.action](opts) end)
end



nui.new = function(opts)


  local choose = {
    send_to_old = {
  border = {
    style = "rounded",
    highlight = "FloatBorder",
    text = { top = string.format(' send_to_old %s ', opts.filepath), top_align = 'center' }
  },
  position = {row = "95%", col = "50%"},
  size = {
    width = "90%",
    height = "20%",
  },
  opacity = 1,
}
}



nui.manager[opts.name] = Popup(choose[opts.name])
nui.manager[opts.name].startup_opts = opts

nui.manager[opts.name].execute_actions = execute_actions

end


nui.open = function(opts)


local function new(opts)
log.info('nui: new')
nui.new(opts)
nui.mount(opts)
if opts.action then nui.manager[opts.name]:execute_actions(opts) end
end

local function unmount_new(opts)
log.info('nui: unmount_new')
nui.unmount(opts)
new(opts)
end

local function execute_actions_only(opts)
  log.info('executing actions only')
if opts.action then nui.manager[opts.name]:execute_actions(opts) end
end






if not nui.manager[opts.name] then

new(opts)

elseif nui.manager[opts.name] then 

log.info(opts)
log.info(opts.filepath)
log.info(nui.manager[opts.name].startup_opts.filepath)
if opts.name == 'send_to_old' and opts.action == 'open_file' and opts.filepath ~= nui.manager[opts.name].startup_opts.filepath then
unmount_new(opts) end

execute_actions_only(opts)
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
    

    if opts.action_args.pos == 'btm' then 
      log.info('pos is bottom!')  
      vim.cmd([[normal! G]])
      end

          end, -- end open_file



}

return nui
