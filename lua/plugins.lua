local execute = vim.api.nvim_command

local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local manual = '~/cl/lua/manual-plug'
local me = '~/cl/lua/me-plug'
local forks = '~/cl/lua/fork-plug'


local packer = nil
local function init() -- only 1 function below here



  if packer == nil then
    packer = require('packer')
    util = require('packer.util')
    -- usein directory location
    packer.init()--{disable_commands = true, opt_default = true})
  end

  local use = packer.use
  local use_rocks = packer.use_rocks
  packer.reset()
 

  
use_rocks {'luaformatter', server = 'https://luarocks.org/dev'}
use_rocks 'luacheck' 
use_rocks 'luarepl'
use_rocks 'mpack' 



use {'wbthomason/packer.nvim', opt = true}


use 'skywind3000/asynctasks.vim' 
use 'skywind3000/asyncrun.vim'
use 'GustavoKatel/telescope-asynctasks.nvim'
use 'dhruvmanila/telescope-bookmarks.nvim'
use 'justinmk/lua-client2'
use 'mhartington/formatter.nvim'
use 'nvim-telescope/telescope-z.nvim'
use 'b3nj5m1n/kommentary'
use 'akinsho/nvim-bufferline.lua'
use {
   'glepnir/galaxyline.nvim',
    branch = 'main'
    -- your statusline/
    -- some optional icons
    -- requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
use 'mhinz/vim-lookup'
use 'sayanarijit/xplr.vim' 
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use { forks .. '/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}


use 'rktjmp/fwatch.nvim'
use 'windwp/nvim-spectre' -- ide like search replace
use  { forks .. '/nui.nvim' } --use 'MunifTanjim/nui.nvim'
use {'prettier/vim-prettier', run = 'npm install'}
use 'nvim-telescope/telescope-packer.nvim'
use 'nvim-telescope/telescope-snippets.nvim'
use { 'fhill2/telescope-ultisnips.nvim'}
use 'tami5/sql.nvim'
use 'nvim-telescope/telescope-cheat.nvim'
use {'nvim-telescope/telescope-frecency.nvim'}
use 'nvim-telescope/telescope-fzy-native.nvim'
use 'norcalli/snippets.nvim' 
use 'rafcamlet/nvim-luapad' 
use 'metakirby5/codi.vim'
use 'svermeulen/vimpeccable'
use 'bfredl/nvim-luadev'
use 'tjdevries/nlua.nvim'
use { me .. '/omnimenu.nvim' } 
use 'neovim/nvim-lspconfig'
use 'kabouzeid/nvim-lspinstall'
use 'hrsh7th/nvim-compe'
use 'ray-x/lsp_signature.nvim' -- auto floating signature help - nvim compe doesnt support
use 'onsails/lspkind-nvim' -- add vscode icons to dropdown
use 'ray-x/navigator.lua' -- "jumping up the callstack" 
use 'tamago324/compe-zsh' -- zsh completions
use 'tjdevries/lsp_extensions.nvim'
use 'glepnir/lspsaga.nvim'
use 'kosayoda/nvim-lightbulb'
use 'nvim-lua/lsp-status.nvim'
use {'iamcco/markdown-preview.nvim'} -- , run = 'cd app & npm install' }
use 'honza/vim-snippets'
use 'SirVer/ultisnips'
use 'L3MON4D3/LuaSnip'
use 'akinsho/nvim-toggleterm.lua'
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'nvim-treesitter/playground'
use 'nvim-treesitter/nvim-treesitter-refactor'
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'romgrk/nvim-treesitter-context'
use 'p00f/nvim-ts-rainbow'
use 'stsewd/sphinx.nvim'
use 'theHamsta/nvim-dap-virtual-text'
use 'hkupty/iron.nvim'
use { me ..  '/codelibrary.nvim' }
use { 'voldikss/vim-floaterm', opt = true }

use { forks .. '/nvim-tree.lua' }
use 'liuchengxu/vista.vim'
use 'lambdalisue/nerdfont.vim'
use 'lambdalisue/glyph-palette.vim'
use 'ryanoasis/vim-devicons'
use {'kyazdani42/nvim-web-devicons', opt = true}
use 'tjdevries/colorbuddy.vim'
use 'folke/tokyonight.nvim'
use 'lambdalisue/vim-gita'
use 'tpope/vim-scriptease'
use 'ms-jpq/neovim-async-tutorial'
use 'fhill2/testrepo'
use 'folke/neoscroll.nvim'
use 'folke/lua-dev.nvim'
use 'folke/todo-comments.nvim'
use 'folke/ultra-runner'
use 'folke/persistence.nvim'
use 'folke/twilight.nvim'

-- sort out
use { me .. '/xplr.nvim', requires = {{'fhill2/telescope.nvim'}}} 



end

local useins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return useins
