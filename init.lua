local api = vim.api
local reload = require'plenary.reload'.reload_module

-- always first incase init fails to load due to plugins
vim.cmd[[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd[[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd[[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd[[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd[[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
vim.cmd[[command! Pi packadd packer.nvim | lua require('plugins').install()]]
vim.cmd[[command! Pu packadd packer.nvim | lua require('plugins').update()]]
vim.cmd[[command! Psy packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd[[command! Pclean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd[[command! Pcompile packadd packer.nvim | lua require('plugins').compile()]]
vim.cmd[[command! Pcomp packadd packer.nvim | lua require('plugins').compile()]]



local function rerequire(req_path)

reload(req_path)
require(req_path)
end


rerequire('globals/init')

lo('====== NVIM STARTUP =====')

rerequire('plugins')

require('plugin/bufferline')
--rerequire('plugin/galaxyline')
rerequire('plugin/galaxyline/neonline')
--rerequire('plugin/lualine')
rerequire('plugin/iron')
rerequire('plugin/formatter')
rerequire('plugin/xplr')
rerequire('plugin/telescope')
rerequire('plugin/kommentary')
rerequire('plugin/lsp/init')
rerequire('plugin/lsp/compe')
rerequire('plugin/markdown-preview')
rerequire('plugin/lsp/compe')
rerequire('plugin/toggleterm')
rerequire('plugin/treesitter')
rerequire('plugin/nvim-tree')
rerequire('plugin/omnimenu')
rerequire('plugin/diffview')

rerequire('keymap/main')
rerequire('keymap/lsp')
rerequire('keymap/luapad')
rerequire('keymap/vista')


-- opts still to add
-- vim.o.wildmode = vim.o.wildmode - 'list'
-- vim.o.wildmenu = vim.o.wildmenu - 'list'

-- vim.o.formatoptions = vim.o.formatoptions - 'a' -- Auto formatting is BAD.
-- - 't' -- Don't auto format my code. I got linters for that.
-- - 'c' -- In general, I like it when comments respect textwidth
-- + 'q' -- Allow formatting comments w/ gq
-- - 'o' -- O and o, don't continue comments
-- - 'r' -- But do continue when pressing enter. f: enter is new comment
-- + 'n' -- Indent past the formatlistpat, not underneath it.-                     + 'j'     -- Auto-remove comments if possible.
-- - '2'


-- Ignore compiled files
vim.o.wildignore = '__pycache__,*.o,*~,*.pyc,*pycache*'
vim.o.wildmode = 'longest,list,full'

-- Cool floating window popup menu for completion on command line
vim.o.pumblend = 17



vim.o.wildoptions = 'pum'
vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1 -- Height of the command bar
vim.o.incsearch = true -- Makes search act like search in modern browsers
vim.o.showmatch = true -- show matching brackets when text indicator is over them
vim.o.relativenumber = true -- Show line numbers
vim.o.number = true -- But show the actual number for the line we're on
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
vim.o.hidden = true -- I like having buffers stay around
vim.o.cursorline = true -- Highlight the current line
vim.o.equalalways = true -- f: changed from false-- I don't like my windows changing all the time
vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom
vim.o.updatetime = 1000 -- Make updates happen faster
vim.o.hlsearch = true -- I wouldn't use this without my DoNoHL function
--avim.o.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Tabs
vim.o.autoindent = false
vim.o.cindent = false
vim.o.wrap = true

vim.o.tabstop = 4 -- number of spaces that a <tab> in the file counts for
vim.o.shiftwidth = 2 -- REMEMBER treesitter uses this value for its indenting. make sure it matches lua-format indenting value
vim.o.softtabstop = 4
vim.o.expandtab = true -- inserting a tab will add spaces instead
vim.o.breakindent = true -- every wrapped line will continue visually indented
vim.o.showbreak = string.rep(' ', 3) -- Make it so that long lines wrap smartly
vim.o.linebreak = true -- wrap long lines at a character in breakat var rather than last char that fits on the screen
vim.o.foldmethod = 'marker'
vim.o.foldlevel = 0
vim.o.modelines = 1
vim.o.belloff = 'all' -- Just turn the dang bell off
vim.o.inccommand = 'split'
vim.o.swapfile = false -- Living on the edge
--vim.o.shada = {"!", "'1000", "<50", "s10", "h"}

vim.o.virtualedit = 'onemore'

vim.o.joinspaces = false -- Two spaces and grade school, we're done
vim.o.mouse = 'a' -- tj: n



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


-- managing luapad between btmwindow & other open lua buffers
vim.api.nvim_command("autocmd WinEnter * lua require'plugin/luapad'.onWinEnter()")


api.nvim_set_current_dir(vim.fn.stdpath('config'))

-- to make sure closing with manual hotkey or specific window hotkey stays in sync on btmwindow state
vim.cmd("autocmd WinClosed * lua require'futil/btmwindow'.onWinClosed()")

--- f: turn auto indent of
vim.cmd([[setlocal nocindent]])
vim.cmd([[setlocal nosmartindent]])


vim.o.timeout = true
vim.o.ttimeout = true

-- https://github.com/neovim/neovim/issues/2051
vim.o.timeoutlen=250 -- keep normal mode mappings slow, but keep it as low as possible so G is fast in normal mode etc
vim.o.ttimeoutlen=0 -- quick escape from insert mode



vim.cmd[[com -nargs=1 -complete=command Redir :execute "tabnew | pu=execute(\'" . <q-args> . "\') | setl nomodified"]]

vim.cmd[[augroup terminal_setup | au!]]
vim.cmd[[autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i]]
vim.cmd[[augroup end]]

--turn off auto commenting for every buffer
vim.cmd[[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

vim.cmd[[autocmd VimEnter * lua require'futil.autocmd'.vimenter()]]



--vim.cmd[[autocmd BufWinLeave term://* lua require'futil.terminal'.bufwinleave()]]



--turn on/off logging for format.nvim lukas-reineke
vim.g.format_debug = true

vim.cmd[[set nobackup]]



--set sessionoptions=blank,buffers,curdir,folds,resize,terminal,winpos,winsize

-- only 1 left out is 'unix from this list:
-- http://vimdoc.sourceforge.net/htmldoc/options.html#'sessionoptions'

-- SESSION OPTIONS that i definitely need:
-- BLANK OFF - if on, luapad window size changes. but then is luapad window is empty buff dissapears
-- CURDIR ON - saves current directory
-- WINSIZE ON - to restore window split dimensions.. maybe keeps not restoring
-- LOCALOPTIONS ON - to restore treesitter syntax highlighting when loading session


-- ALL sessionoptions available below
vim.cmd[[set sessionoptions=]]
vim.cmd[[set sessionoptions-=globals ]] -- YOU CANT EXPORT TABLES / DICTS. only strings or numbers. also leave off if i can otherwise it will copy globals that i change 
vim.cmd[[set sessionoptions+=blank]]
vim.cmd[[set sessionoptions+=buffers]]
vim.cmd[[set sessionoptions+=curdir]]
vim.cmd[[set sessionoptions-=folds]]
vim.cmd[[set sessionoptions-=help]]
vim.cmd[[set sessionoptions+=localoptions]]
vim.cmd[[set sessionoptions-=options]] -- global options keeps the state of sessionoptions inside the file so if you change on other nvim the changes wont stick
vim.cmd[[set sessionoptions-=resize]] -- size of whole vim window ignore
vim.cmd[[set sessionoptions-=sesdir]]
vim.cmd[[set sessionoptions-=slash]]
vim.cmd[[set sessionoptions-=tabpages]]
vim.cmd[[set sessionoptions-=winpos]] -- position of whole vim window ignore
vim.cmd[[set sessionoptions+=winsize]] -- each split size

vim.cmd[[set clipboard=unnamedplus]]

vim.cmd('colorscheme tokyonight')

vim.cmd('let g:UltiSnipsSnippetDirectories=[$HOME."/cl/snippets/ultisnips"]')
--vim.cmd([[e ~/cl/lua/scratch/mroavi2.lua]])
--
--
--
--
--
--
--
--
--

-- local leader = " "

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<space>ll", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
