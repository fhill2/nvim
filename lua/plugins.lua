local execute = vim.api.nvim_command
local fn = vim.fn
print('PLUGINS LOADED')
--local packer_custom_updater = require 'plugin/packer_custom_updater'
--local log = require'log1'

-- orig: local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local plugins_manual = '/home/f1/code/nvim-configs//nvim-main/plugins-manual'
local plugins_me = '/home/f1/code/nvim-configs/nvim-main/plugins-me'

-- install path for packer
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

local packer = nil
local function init() -- only 1 function below here



  if packer == nil then
    packer = require('packer')
    util = require('packer.util')
    -- usein directory location
    packer.init({disable_commands = true, opt_default = true})
  end

  local use = packer.use
  local use_rocks = packer.use_rocks
  packer.reset()
 -- do not uncomment
 -- use { plugins_me .. '/floating.nvim' }
 -- use { 'fhill2/floating.nvim', lock = true } --  run = 'git fetch --unshallow' }
  use { plugins_me .. '/shell-repl.nvim'}


  -- Packer
  -- how to put useins into separate folders:
  -- use {'dracula/vim', as = 'dracula/draculaasd2'}
  use {'wbthomason/packer.nvim', opt = true}

use 'skywind3000/asynctasks.vim' 
use 'skywind3000/asyncrun.vim'
use 'GustavoKatel/telescope-asynctasks.nvim'

use 'dhruvmanila/telescope-bookmarks.nvim'

use 'justinmk/lua-client2'
use_rocks 'mpack'

  -- tmux stuff

  -- use 'roxma/vim-tmux-clipboard' -- needed to make clipboard work

  -- rocks

  use_rocks {'luaformatter', server = 'https://luarocks.org/dev'}
  use_rocks 'luacheck' 
  execute 'packadd packer.nvim'

  use_rocks 'luarepl'
  -- use_rocks {'lua-format'}

 -- use 'lukas-reineke/format.nvim'
  --use '/home/f1/.config/nvim/plugins-manual/format.nvim'
  -- didnt use this, error on format
  use 'mhartington/formatter.nvim'

  -- use 'nvim-telescope/telescope-z.nvim'
  -- end rocks

  -- a
  -- new plugins to try
  use 'b3nj5m1n/kommentary'
  -- use 'beauwilliams/statusline.lua'
  -- use 'tpope/vim-commentary'
  use 'akinsho/nvim-bufferline.lua' -- my own pick

  -- other bufferlines 
  -- https://github.com/romgrk/barbar.nvim

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main'
    -- your statusline/
    -- some optional icons
    -- requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'mhinz/vim-lookup'

  use 'sayanarijit/xplr.vim' 
  ----- end new plugins ----

  -- telescope & extensions
  --use 'nvim-lua/popup.nvim'
  --use 'nvim-lua/plenary.nvim'
  --use { 'nvim-telescope/telescope.nvim', opt = true }

  use 'fhill2/popup.nvim'
  use 'fhill2/plenary.nvim'
  use { 'fhill2/telescope.nvim', opt = true }


use 'rktjmp/fwatch.nvim'
--        opt = true,
--         config = function()    
--           require('telescope').setup{
--     defaults = {
--      results_width = 0.1,
--      layout_strategy = 'horizontal',
--    --  results_height = 44,
--    --  height = 44
--  },
--  extensions = {
--     frecency = {
--       show_scores = true,
--       show_unindexed = true,
--       ignore_patterns = {"*.git/*", "*/tmp/*"},
--       workspaces = {
--         ["conf"]    = "/home/f1/.config",
--         ["data"]    = "/home/f1/.local/nvim"
--       }
--     },
-- fzy_native = {
--             override_generic_sorter = true,
--             override_file_sorter = true,
--         }
--   },
--  }
--         end
--       }


      -- use {
  -- 'nvim-telescope/telescope.nvim',
  --     depends = { 'kyazdani42/nvim-web-devicons', opt = true }

  -- }
  --use 'MunifTanjim/nui.nvim'
  --use { plugins_manual .. '/nui.nvim' }
  
  use 'fhill2/nui.nvim'

  use {'prettier/vim-prettier', run = 'npm install'}

  use 'nvim-telescope/telescope-packer.nvim'
  use 'nvim-telescope/telescope-snippets.nvim'
   -- opt = true,

    --  config = function() require'telescope'.load_extension('snippets') end
  --  }
 -- use { "nvim-telescope/telescope-frecency.nvim", opt = true }

  use { 'fhill2/telescope-ultisnips.nvim', 
  opt = true, 
   config = function() 
      require'telescope'.load_extension('ultisnips') end
--setup = function() require'telescope'.load_extension('Ultisnips') end
 }




  use 'tami5/sql.nvim'
  use 'nvim-telescope/telescope-cheat.nvim'

 --  use { 'nvim-telescope/telescope-frecency',
 --   opt = false,
 --   config = function() require"telescope".load_extension("frecency") end
 -- }
use {'nvim-telescope/telescope-frecency.nvim'}

  use 'nvim-telescope/telescope-fzy-native.nvim'

 -- use { plugins_me .. '/telefrecency.nvim' }

  use 'norcalli/snippets.nvim'
  -- lua 

  use 'rafcamlet/nvim-luapad'
 
 -- this is most current luapad
 --  use '/home/f1/.config/nvim/plugins-manual/nvim-luapad'
use 'metakirby5/codi.vim'


  -- updater = function(x)
  -- require log1 = require'log1'
  -- end }

  use 'svermeulen/vimpeccable'

  use 'bfredl/nvim-luadev'
  use 'tjdevries/nlua.nvim'
  -- use 'euclidianAce/BetterLua.vim'
  -- use 'tjdevries/vlog.nvim'
  -- use 'tjdevries/manillua.nvim'

  -- use 'kyazdani42/nvim-tree.lua'
  --use { plugins_manual .. '/nvim-tree.lua' }
use 'fhill2/nvim-tree.lua'
--

  use { plugins_me .. '/omnimenu.nvim' }
  -- lsp 
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim' -- auto floating signature help - nvim compe doesnt support
  use 'onsails/lspkind-nvim' -- add vscode icons to dropdown
  use 'ray-x/navigator.lua' -- "jumping up the callstack" 
  use 'tamago324/compe-zsh' -- zsh completions

 -- use {'nvim-lua/completion-nvim'}
 -- use 'fhill2/ultipreview.nvim'

  -- use 'Shougo/deoplete.nvim' --  { 'do': ':UpdateRemotePlugins' }

  -- use 'C:/Users/F1/AppData/Local/nvim/plugins-me/ultisnippets-preview-nvim'
  -- use 'C:/Users/F1/AppData/Local/nvim/plugins-manual/completion-nvim'
  use 'tjdevries/lsp_extensions.nvim'
  --use 'ncm2/float-preview.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'kosayoda/nvim-lightbulb'
  use 'nvim-lua/lsp-status.nvim'

  use {'iamcco/markdown-preview.nvim'} -- , run = 'cd app & npm install' }

  -- lsp snippets
  use 'honza/vim-snippets'
  use 'SirVer/ultisnips'

  use 'L3MON4D3/LuaSnip'


  use 'akinsho/nvim-toggleterm.lua'

  -- treesitter
  -- use 'christianchiarulli/nvcode-color-schemes.vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'

  -- treesitter all extensions - trying out
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow'
  use 'stsewd/sphinx.nvim'
  use 'theHamsta/nvim-dap-virtual-text'

  use 'hkupty/iron.nvim'


 -- use { plugins_me .. '/livetablelogger.nvim' }

  use { plugins_me ..  '/codelibrary.nvim' }


   use 'voldikss/vim-floaterm'

use { plugins_me .. '/xplr.nvim'} 

  -- other 
  -- use 'equalsraf/neovim-gui-shim'

  -- viml
  -- use '907th/vim-auto-save'

  -- use {
  --   'lambdalisue/fern.vim',
  --     requires = {'lambdalisue/fern-renderer-nerdfont.vim', opt = true}
  -- }


use 'liuchengxu/vista.vim'

  use 'junegunn/fzf.vim'
  use 'junegunn/fzf'
  use 'mhinz/vim-startify'

  -- font icons
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/glyph-palette.vim'
  use 'ryanoasis/vim-devicons'

  use {'kyazdani42/nvim-web-devicons', commit = 'aaffb87', opt = true}

  use 'tjdevries/colorbuddy.vim'
  -- treesitter full lua awesome-neovim color schemes

  -- colorbuddy themes
  use 'Th3Whit3Wolf/onebuddy'
  use 'Th3Whit3Wolf/spacebuddy'
  use 'ishan9299/modus-theme-vim'
  use 'tjdevries/gruvbuddy.nvim'

  -- awesome neovim themes
  -- 
  -- use 'Th3Whit3Wolf/one-nvim' -- DOESNT support treesitter highlighting
  use 'cooper-anderson/glowbeam.nvim'
  use 'mhartington/oceanic-next'
  use 'kyazdani42/blue-moon'
  use 'glepnir/zephyr-nvim'
  use 'rockerBOO/boo-colorscheme-nvim'
  use 'theniceboy/nvim-deus'
  use 'bkegley/gloombuddy'

  use 'lambdalisue/vim-gita'

  -- coc 
  -- use { 'neoclide/coc.nvim', opt = true }
  -- use 'rafcamlet/coc-nvim-lua'

  -- leave out replaced plugins
  -- use 'liuchengxu/vim-which-key'
  -- use 'vim-airline/vim-airline'
  -- use 'vim-airline/vim-airline-themes'
  -- use 'puremourning/vimspector'
  -- use 'mfussenegger/nvim-dap'
  -- use 'theHamsta/nvim-dap-virtual-text'
  use 'tpope/vim-scriptease'
  -- use 'vim-scripts/genutils'
  -- use 'albfan/vim-breakpts'
  -- use 'sbdchd/neoformat'
  -- use 'voldikss/vim-floaterm'
  -- use 'preservim/nerdcommenter'
  -- use 'airblade/vim-rooter'
  -- use 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

  -- leave out replaced plugins lsp
  -- use 'lighttiger2505/deoplete-vim-lsp'
  -- use 'Shougo/deoplete.nvim', { 'do': ':UpdateRemoteuseins' }
  -- use 'thomasfaingnaert/vim-lsp-snippets'
  -- use 'thomasfaingnaert/vim-lsp-ultisnips'
  --

  use 'ms-jpq/neovim-async-tutorial'
  use 'fhill2/testrepo'

end

local useins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return useins
