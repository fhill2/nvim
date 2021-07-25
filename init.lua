local execute = vim.api.nvim_command
local fn = vim.fn
local api = vim.api


--local futil = require 'futil'
--local log1 = require 'log1'

require('plugins')
-- START dont turn these ones off when debugging
execute 'packadd plenary.nvim'
execute 'packadd popup.nvim'
execute 'packadd nui.nvim'




-- package.loaded['tj.globals'] = nil
-- local globals_ok, msg = pcall(require, 'tj.globals.init')
-- if not globals_ok then print("Failed to load globals:", msg) end



-- if not globals_ok then
--   print("Quitting early after loading plugins.")
--   print("You probably need to install them...")
--   return
-- end

--execute 'packadd livetablelogger.nvim'


require('plenary.reload').reload_module("globals/init")
require('globals/init')

require('plenary.reload').reload_module("globals/opt")
require('globals/opt')

--lo('BEGIN STARTUP')
--require('globals')
--lo('fstate is: ')
--lo(fstate)

execute 'packadd lua-client2'

execute 'packadd galaxyline.nvim'
require('plenary.reload').reload_module("plugin/galaxyline")
require('plugin/galaxyline')


-- END DONT turn these ones off when debugging

-- always load first
execute 'packadd nvim-web-devicons'
execute 'packadd nerdfont.vim'
execute 'packadd glyph-palette.vim'
execute 'packadd vim-devicons'
execute 'packadd vim-snippets'

execute 'packadd nvim-luapad'
--require('plenary.reload').reload_module("plugin/luapad")
--require('plugin/luapad')
execute 'packadd codi.vim'
execute 'packadd iron.nvim'
require('plugin/iron')


execute 'packadd snippets.nvim'
execute 'packadd telescope-snippets.nvim'

execute 'packadd nvim-bufferline.lua'
--require('plenary.reload').reload_module("plugin/bufferline") -- reload is broken for bufferline
require('plugin/bufferline')

--execute 'packadd floating.nvim'
execute 'packadd shell-repl.nvim'

-- require('plenary.reload').reload_module("plugin/floating")
-- require('plugin/floating')

execute 'packadd vim-lookup'

execute 'packadd formatter.nvim'
require('plenary.reload').reload_module("plugin/formatter")
require('plugin/formatter')


execute 'packadd telescope.nvim'
execute 'packadd telescope-packer.nvim'

--execute 'packadd telescope-frecency.nvim'
execute 'packadd telescope-fzy-native.nvim'
execute 'packadd telescope-bookmarks.nvim'

execute 'packadd telescope-ultisnips.nvim'

execute 'packadd xplr.vim'


execute 'packadd xplr.nvim'
require('plenary.reload').reload_module("plugin/xplr")
require('plugin/xplr')


execute 'packadd sql.nvim'
execute 'packadd telescope-cheat.nvim'
require('plenary.reload').reload_module("plugin/telescope")
require('plugin/telescope')

--execute 'packadd telefrecency.nvim'

-- k is lua comment, c commentary is tpope
execute 'packadd kommentary'
require('plenary.reload').reload_module("plugin/kommentary")
require('plugin/kommentary')

execute 'packadd nvim-luadev'
execute 'packadd nlua.nvim'

execute 'packadd nvim-lspconfig'
execute 'packadd nvim-lspinstall'

execute 'packadd nvim-compe'
execute 'packadd lsp_signature.nvim'
execute 'packadd lspkind-nvim'
execute 'packadd navigator.lua'
execute 'packadd compe-zsh'
--execute 'packadd completion-nvim'
--execute 'packadd ultipreview.nvim'
execute 'packadd lsp_extensions.nvim'
--execute 'packadd float-preview.nvim'
execute 'packadd lspsaga.nvim'
execute 'packadd nvim-lightbulb'
execute 'packadd lsp-status.nvim'

require('plenary.reload').reload_module("plugin/compe")
require('plenary.reload').reload_module("plugin/lsp/init")
require('plenary.reload').reload_module("plugin/lsp/status")
require('plugin/compe')
require('plugin/lsp/init')
require('plugin/lsp/status')

execute 'packadd markdown-preview.nvim'

execute 'packadd ultisnips'

execute 'packadd LuaSnip'


execute 'packadd nvim-toggleterm.lua'
require('plenary.reload').reload_module("plugin/toggleterm")
require('plugin/toggleterm')


require('plenary.reload').reload_module("plugin/treesitter")
execute 'packadd nvim-treesitter'
require('plugin/treesitter')

-- treesitter all extensions - trying out
execute 'packadd nvim-treesitter-refactor'
execute 'packadd nvim-treesitter-textobjects'
execute 'packadd nvim-treesitter-context'
execute 'packadd nvim-ts-rainbow'
execute 'packadd sphinx.nvim'
execute 'packadd nvim-dap-virtual-text'

execute 'packadd playground'

execute 'packadd fzf.vim'
execute 'packadd fzf'
--execute 'packadd vim-startify'

execute 'packadd vimpeccable'

execute 'packadd vim-gita'

execute 'packadd vim-scriptease'

execute 'packadd colorbuddy.vim'

execute 'packadd onebuddy'
execute 'packadd spacebuddy'
execute 'packadd modus-theme-vim'
execute 'packadd gruvbuddy.nvim'

execute 'packadd glowbeam.nvim'
execute 'packadd oceanic-next' -- colorscheme OceanicNext
execute 'packadd blue-moon'
execute 'packadd zephyr-nvim'
execute 'packadd boo-colorscheme-nvim'
execute 'packadd nvim-deus'
execute 'packadd gloombuddy'

vim.cmd([[colorscheme onebuddy]])


execute 'packadd nvim-tree.lua'
-- require('plenary.reload').reload_module("plugin/nvim-tree")
-- require('plugin/nvim-tree')

execute 'packadd vim-floaterm'


execute 'packadd asynctasks.vim'
execute 'packadd asyncrun.vim'
execute 'packadd telescope-asynctasks.nvim'

execute 'packadd codelibrary.nvim'

execute 'packadd fwatch.nvim'

lo('====== NVIM STARTUP =====')



execute 'packadd vista.vim'

-- IGNORE
-- execute 'packadd BetterLua.vim'
-- execute 'packadd vim-commentary'
-- execute 'packadd formatter.nvim' -- mhartington, not using cause of error



-- KEYMAPS
require('plenary.reload').reload_module("keymap/main")
require('keymap/main')
--require('plenary.reload').reload_module("keymap/telescope")
--require('keymap/telescope')
require('plenary.reload').reload_module("keymap/lsp")
require('keymap/lsp')
require('plenary.reload').reload_module("keymap/luapad")
require('keymap/luapad')
--require('plenary.reload').reload_module("keymap/nvim-tree")
--require('keymap/nvim-tree')
require('plenary.reload').reload_module("keymap/vista")
require('keymap/vista')


execute 'packadd testrepo'


execute 'packadd neovim-async-tutorial'


-- keep at end so it loads all modules
execute 'packadd omnimenu.nvim'
require('plenary.reload').reload_module("plugin/omnimenu")
require('plugin/omnimenu')


local opt = vim.opt

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore = opt.wildignore + {'*.o', '*~', '*.pyc', '*pycache*'}

opt.wildmode = {'longest', 'list', 'full'}

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17

opt.wildmode = opt.wildmode - 'list'
opt.wildmode = opt.wildmode + {'longest', 'full'}

opt.wildoptions = 'pum'

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.cursorline = true -- Highlight the current line
opt.equalalways = true -- f: changed from false-- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
--aopt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Tabs
opt.autoindent = false -- tj: true
opt.cindent = false -- tj: true
opt.wrap = true

opt.tabstop = 4 -- number of spaces that a <tab> in the file counts for
opt.shiftwidth = 2 -- REMEMBER treesitter uses this value for its indenting. make sure it matches lua-format indenting value
opt.softtabstop = 4
opt.expandtab = true -- inserting a tab will add spaces instead
opt.breakindent = true -- every wrapped line will continue visually indented
opt.showbreak = string.rep(' ', 3) -- Make it so that long lines wrap smartly
opt.linebreak = true -- wrap long lines at a character in breakat var rather than last char that fits on the screen
opt.foldmethod = 'marker'
opt.foldlevel = 0
opt.modelines = 1
opt.belloff = 'all' -- Just turn the dang bell off
opt.inccommand = 'split'
opt.swapfile = false -- Living on the edge
opt.shada = {"!", "'1000", "<50", "s10", "h"}

opt.virtualedit = 'onemore'
opt.formatoptions = opt.formatoptions - 'a' -- Auto formatting is BAD.
- 't' -- Don't auto format my code. I got linters for that.
- 'c' -- In general, I like it when comments respect textwidth
+ 'q' -- Allow formatting comments w/ gq
- 'o' -- O and o, don't continue comments
- 'r' -- But do continue when pressing enter. f: enter is new comment
+ 'n' -- Indent past the formatlistpat, not underneath it.-                     + 'j'     -- Auto-remove comments if possible.
- '2'

opt.joinspaces = false -- Two spaces and grade school, we're done
opt.mouse = 'a' -- tj: n

-- for tracking last active window telescope etc
-- has to be BufEnter instead of WinEnter otherwise doesnt work when first opening btmwindow
-- require('plenary.reload').reload_module("globals/fstate")
-- require('globals/fstate')

--debug.sethook(print, "l")

--local ltlp = require'livetablelogger/tablelog'
fstate = {
  window = {
    included = {},
    excluded = {},
    current_winnr = nil
  },
  nvimtree_cwd = nil,
  btmwindow = {
    luapad = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    fterminal = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    quickfix = {
      winnr = nil,
      bufnr = nil,
      position = nil
    }
  },
  btmwindow_exists = false,
  luapad = {
    filenames = { origfiles = {} },
    editor_eval_on_change = false,
    btmwindow_eval_on_change = true
  },
  telescope = {
    results = { bufnr = false },
    preview = { bufnr = false },
    test = 0,
    uipreset = {
      list = { 'height50' },
      active = 'height50'
    }
  },
  floating = {},
  log = { 
  mode = 'off', -- whitelist/off/all -- all will bypass filter
  whitelist = { 'fstate.luapad' }
}
}

fstate_floating = {
views = {},
recent = {}
}

--print(vim.inspect(fstate))
--lo(tostring(getfenv(1)))
-- for k, v in pairs(fstate) do 
-- print(k)
-- end

--setmetatable(fstate, {__index = function() lo('asd') end}, 'from startup')
--print(vim.inspect(fstate))



-- local t = {}
-- local mtt = { __index = function() end}
-- setmetatable(t, mtt)
--lo(debug.getinfo(setmetatable))
--setmetatable()
--lo('right after fstate')
--print(fstate)

-- current/last win update only
--vim.api.nvim_command("autocmd WinEnter * lua require'futil/window'.onWinEnter()")
-- set state at nvim startup
--vim.api.nvim_command("autocmd VimEnter * lua require'futil/window'.onVimEnter()")
-- track included excluded windows only
--vim.api.nvim_command("autocmd WinNew,WinClosed * lua require'futil/window'.onWinNewClosed()")

-- managing luapad between btmwindow & other open lua buffers
vim.api.nvim_command("autocmd WinEnter * lua require'plugin/luapad'.onWinEnter()")

--vim.cmd("autocmd ColorScheme * lua require'futil/colors'.applyCustomColors()")

api.nvim_set_current_dir(vim.fn.stdpath('config'))

-- to make sure closing with manual hotkey or specific window hotkey stays in sync on btmwindow state
vim.cmd("autocmd WinClosed * lua require'futil/btmwindow'.onWinClosed()")

-- saving a session for each instance of nvim to have persistent temporary sessions
-- not using BufEnter because it saves session at startup sometimes before nvim has loaded the last session. WInEnter doesnt trigger on first window entry
-- vim.cmd([[autocmd VimLeavePre,WinNew * lua require'futil/session'.saveSession()]])
-- vim.cmd([[autocmd VimLeavePre * lua require'futil/session'.onVimLeavePre()]])
-- vim.cmd([[autocmd VimEnter * lua require'futil/session'.restoreSession()]])

-- vim.cmd([[autocmd WinClosed * lua require'plugin/nvim-tree'.onWinClosed()]])


-- -- clipboard, on text yank send back to windows
vim.cmd([[autocmd TextYankPost * lua require'futil/clipboard'.onTextYankPost()]])

-- telescope resize post telescope window popup
--vim.cmd([[autocmd Filetype TelescopePrompt lua require'plugin/telescope'.onTelescopePrompt()]])

--- f: turn auto indent of
vim.cmd([[setlocal nocindent]])
vim.cmd([[setlocal nosmartindent]])

--lo('FINISHED STARTING UP')
--lo('======= STARTUp ======')
--lo(fstate)


-- old
if vim.v.servername == '/tmp/nvim4' then
require'omnimenu'.show_telescope()
-- vim.cmd([[autocmd VimEnter * lua (function() require'omnimenu'.show_telescope()
--  end)()]])
end

local servername = vim.v.servername
--if servername:find('/tmp/nvim%d$') ~= nil then
local cmd = string.format([[autocmd VimLeavePre * lua require'futil/utils'.remove_socket('%s')]], servername)
vim.cmd(cmd)
--end


-- old session autocmds

-- autocmd VimLeave * call SaveSess() -- run ahk restore window pos before

-- vim.cmd([[autocmd SessionLoadPost * lua require'futil/session'.onSessionLoadPost()]])
-- require'futil/session'.session_load_post_retrigger = true



--vim.api.nvim_command("autocmd BufEnter * lua require'plugin/luapad'.onBufEnter()")


--if vim.o.servername == '/tmp/nvim2' then
--vim.cmd([[luafile /home/f1/.config/nvim/lua/asd6.lua]])

--end


require'shell-repl'.setup({
  eval_on_change = false

})

--vim.cmd('e /home/f1/code/nvim-configs/nvim-main/lua/teletest.lua')
---vim.cmd('e /home/f1/code/nvim-configs/nvim-main/lua/popup-test.lua')
