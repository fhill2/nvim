local autocmd = {}


function autocmd.vimenter()


-- load tabpages

for i = 1, 7, 1 do
vim.cmd('tabnew')
end

vim.api.nvim_set_current_tabpage(1)

end



return autocmd
