local M = {}
-- clear highlight:
-- hi ..copy highlight group ie CursorColumn
-- highlight clear <group>
M.applyCustomColors = function()

-- DISABLED THESE
    -- vim.cmd([[hi StatusLineNC guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[hi StatusLine guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[set fillchars=vert:\  ]])
    -- vim.cmd([[hi VertSplit guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[hi Normal guibg=]] .. M.colors_desaturate.zero)
    -- vim.cmd([[hi NormalNC guibg=]] .. M.colors_desaturate.fifty)
    -- vim.cmd([[hi clear SignColumn]])

    -- -- for treesitter extension highlight current context
    -- vim.cmd([[hi TSCurrentScope guibg=]] .. M.colors_darken.ten)
    -- -- for treesitter highlight definition automatically from treesitter refactor
    -- vim.cmd([[hi TSDefinitionUsage guibg=]] .. M.colors.magenta)
    -- vim.cmd([[hi TSDefinition guibg=]] .. M.colors.magenta)
-- DISABLED THESE END




    -- setup for nvim-qt windows
    -- vim.cmd([[hi StatusLineNC guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[hi StatusLine guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[set fillchars=vert:\  ]])
    -- vim.cmd([[hi VertSplit guibg=]] .. M.colors.section_bg)
    -- vim.cmd([[hi Normal guibg=#282c34]]) 
    -- vim.cmd([[hi NormalNC guibg=#2b2d31]])
end








-- how i did bg color de saturate:
-- https://mdigi.tools/desaturate-color/#282c34
-- 1st start with 282c34. saturate 50% to 2b2d31
-- Normal = active window. NormalNC = all non current / non active windows
M.colors_desaturate = {
    zero = '#282c34', fifty = '#2b2d31', ninetynine = '#2e2e2e'
}

-- https://pinetools.com/change-color-saturation
-- testing lightening for treesitter 
M.colors_lighten = {zero = '#282c34', twentyfive = '#222a39'}

-- https://hexcolorcodes.org/darken-color
-- darken color 
M.colors_darken = {zero = '#282c34', ten = '#1E222A', twentyfive = '#141820'}

-- Colors
-- old bg = '#282a36',
M.colors = {
    bg = '#38393f', fg = '#f8f8f2', section_bg = '#38393f', yellow = '#f1fa8c',
    cyan = '#8be9fd', green = '#50fa7b', orange = '#ffb86c',
    magenta = '#ff79c6', blue = '#8be9fd', red = '#ff5555'
}

return M
