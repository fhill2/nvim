local actions = require'omnimenu.actions'
local send_to_old = require'futil/send_to_old'
local log = require'log1'

--- some shiz here
require'omnimenu'.setup {

{
    name = 'Omnimenu - open',
    action = function() require('omnimenu').show_telescope() end,
    keymap = {{'n', '<F1>', {}}, {'n', '<space>af', {}}}
    --, {}}, {'!', '<F1>', {}}, {'', '<A-a>f', {}}, {'!', '<A-a>f', {}}}
  },

 {
    cat = "custom",
    desc = "",
    name = "open Config: Omnimenu",
    subcat = "",
    action = function() 
      actions.open_in_floating('omnimenu/config', true, { name = 'main', title='Omnimenu Config'})
    end,
   keymap = { {'n', '<F8>', {} }} --, {'!', '<F8>', {}} }
  },

--- ============= <C-> MAPPINGS ============
 {
    name = 'send_to_old test',
    action = function() require('futil/send_to_old').test() end,
    keymap = {{'n', '<C-a>m', {}}, {'!', '<C-a>m', {}}}
  },

 {
    cat = "custom",
    desc = "",
    name = "send_to_old: open floating window ONLY",
    subcat = "",
    action = function() 
      -- create_dest retrieves filepath and makes sure file and all folders to the filepath are created
      local dest_filepath = send_to_old.create_dest()
   
     actions.open_in_floating(dest_filepath, false, { name = 'main', title='send_to_old' })
     end,
   keymap = { {'', '<C-a>h', {} }, {'!', '<C-a>h', {}} }
  },
 {
    cat = "thismissing",
    desc = "custoize desc123",
    name = "send_to_old: send visual selection and open window",
    subcat = "",
    action = function() send_to_old.send_visual() end,
   keymap = { {'', '<C-a>g', {}}, {'!', '<C-a>g', {}} }
  },
  {
    name = 'nui - close all floating windows',
    action = function() require('plugin/nui').close_all_windows() end,
    keymap = {{'', '<C-a>e', {}},{'!', '<C-a>e', {}}}
  },
 {
    name = 'telescope - close persistent',
    action = function() require('plugin/telescope').close('persistent') end,
    keymap = {{'', '<C-a>q', {}}, {'!', '<C-a>q', {}}}
  },
{
    name = 'telescope - focus persistent',
    action = function() require('plugin/telescope').focus('persistent') end,
    keymap = {{'', '<C-a>w', {}}, {'!', '<A-a>w', {}}}
  },

 {
    name = 'nui - focus cycle',
    action = function() require("plugin/nui").focus() end,
    keymap = {{'', '<C-a>j', {}}, {'!', '<C-a>j', {}}}
  },



  --- =========== SPECTRE FIND REPLACE =======
 {
    name = 'spectre - open',
    action = function() require'spectre'.open() end,
    keymap = {{'n', '<space>sd', {}}} --, {'!', '<A-a>a', {}}}
  },
{
    name = 'spectre - open selected word in normal mode',
    action = function() require'spectre'.open_visual() end,
    keymap = {{'n', '<space>sg', {}}} --, {'!', '<A-a>a', {}}}
  },
{
    name = 'spectre - open visual selection',
    action = function() require'spectre'.open_visual() end,
    keymap = {{'v', '<space>ss', {}}} --, {'!', '<A-a>a', {}}}
  },
{
    name = 'spectre - open file search',
    action = function() require'spectre'.open_file_search() end,
    keymap = {{'n', '<space>sf', {}}} --, {'!', '<A-a>a', {}}}
  },





 --- ============= TELESCOPE =============
---  ===== persistence ====


 ---   ==== find_files ====
 {
    name = 'telescope - find_files - cwd',
    action = function() require('plugin/telescope').find_files({cwd = vim.fn.getcwd() }) end,
    keymap = {{'n', '<space>aa', {}}} --, {'!', '<A-a>a', {}}}
  },
 {
    name = 'telescope - find_files - .dotfiles',
    action = function() require('plugin/telescope').find_files({ cwd = '/home/f1/.dotfiles'}) end,
    keymap = {{'n', '<space>ad', {}}} --, {'!', '<A-a>d', {}}}
  },
 {
    name = 'telescope - find_files - code library',
    action = function() require('plugin/telescope').find_files({ cwd = '~/cl' }) end,
    keymap = {{'n', '<space>ac', {}}} --, {'!', '<A-a>c', {}}}
  },
 {
    name = 'telescope - find_files - nvim plugins',
    action = function() require('plugin/telescope').find_files({ cwd = string.format('%s/site/pack/packer', vim.fn.stdpath('data'))}) end,
    keymap = {{'n', '<space>av', {}}} --, {'!', '<A-a>v', {}}}
  },
 {
    name = 'telescope - find_files - plugins-manual',
    action = function() require('plugin/telescope').find_files({ cwd = '~/code/obsidian/DEV'}) end,
    keymap = {{'n', '<space>ab', {}}} --, {'!', '<A-a>b', {}}}
  },
 {
    name = 'telescope - find_files - plugins-me',
    action = function() require('plugin/telescope').find_files({ cwd = string.format('%s/plugins-me', vim.fn.stdpath('config'))}) end,
    keymap = {{'n', '<space>an', {}}} --, {'!', '<A-a>n', {}}}
  },
--- ==== live_grep ====
 {
    name = 'telescope - live_grep - cwd',
    action = function() require('plugin/telescope').live_grep({cwd = vim.fn.getcwd() }) end,
    keymap = {{'n', '<space>da', {}}} --, {'!', '<A-d>a', {}}}
  },
 {
    name = 'telescope - live_grep - .dotfiles',
    action = function() require('plugin/telescope').live_grep({ cwd = '~/.dotfiles'}) end,
    keymap = {{'n', '<space>dd', {}}} --, {'!', '<A-d>d', {}}}
  },
 {
    name = 'telescope - live_grep - code library',
    action = function() require('plugin/telescope').live_grep({ cwd = '~/cl' }) end,
    keymap = {{'n', '<space>dc', {}}} --, {'!', '<A-d>c', {}}}
  },
 {
    name = 'telescope - live_grep - nvim plugins',
    action = function() require('plugin/telescope').live_grep({ cwd = string.format('%s/site/pack/packer', vim.fn.stdpath('data'))}) end,
    keymap = {{'n', '<space>dv', {}}} --, {'!', '<A-d>v', {}}}
  },
 {
    name = 'telescope - live_grep - plugins-manual',
    action = function() require('plugin/telescope').live_grep({ cwd = '~/code/obsidian/DEV'}) end,
    keymap = {{'n', '<space>db', {}}} --, {'!', '<A-d>b', {}}}
  },
 {
    name = 'telescope - live_grep - plugins-me',
    action = function() require('plugin/telescope').live_grep({ cwd = string.format('%s/plugins-me', vim.fn.stdpath('config'))}) end,
    keymap = {{'n', '<space>dn', {}}} --, {'!', '<A-d>n', {}}}
  },

 --- ==== file browser ====
{
    name = 'telescope - file_browser - cwd',
    action = function() require('plugin/telescope').file_browser({cwd = vim.fn.getcwd() }) end,
    keymap = {{'n', '<space>za', {}}} --, {'!', '<A-z>a', {}}}
  },
 {
    name = 'telescope - file_browser - .dotfiles',
    action = function() require('plugin/telescope').file_browser({ cwd = '~/.dotfiles'}) end,
    keymap = {{'n', '<space>zd', {}}} --, {'!', '<A-z>d', {}}}
  },
 {
    name = 'telescope - file_browser - code library',
    action = function() require('plugin/telescope').file_browser({ cwd = '~/cl' }) end,
    keymap = {{'n', '<space>zc', {}}} --, {'!', '<A-z>c', {}}}
  },
 {
    name = 'telescope - file_browser - nvim plugins',
    action = function() require('plugin/telescope').file_browser({ cwd = string.format('%s/site/pack/packer', vim.fn.stdpath('data'))}) end,
    keymap = {{'n', '<space>zv', {}}} --, {'!', '<A-z>v', {}}}
  },
 {
    name = 'telescope - file_browser - plugins-manual',
    action = function() require('plugin/telescope').file_browser({ cwd = '~/code/obsidian/DEV'}) end,
    keymap = {{'n', '<space>zb', {}}} --, {'!', '<A-z>b', {}}}
  },
 {
    name = 'telescope - file_browser - plugins-me',
    action = function() require('plugin/telescope').file_browser({ cwd = string.format('%s/plugins-me', vim.fn.stdpath('config'))}) end,
    keymap = {{'n', '<space>zn', {}}} --, {'!', '<A-z>n', {}}}
  },



--- ==== buffers ====
 {
    name = 'telescope - buffers',
    action = function() require('plugin/telescope').buffers() end,
    keymap = {{'n', '<space>zb', {}}} --, {'!', '<A-a>b', {}}}
  },



-- keymaps to add
-- api.nvim_set_keymap('', '<A-a>k', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>k', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>m', [[<cmd>lua require('telescope.builtin').man_pages()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>m', [[<cmd>lua require('telescope.builtin').man_pages()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>q', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>q', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>e', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>e', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>g', [[<cmd>lua require('telescope.builtin').builtin()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>g', [[<cmd>lua require('telescope.builtin').builtin()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>o', [[<cmd>lua require('telescope.builtin').registers()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>o', [[<cmd>lua require('telescope.builtin').registers()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>r', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>r', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>v', [[<cmd>lua require('telescope.builtin').commands()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>v', [[<cmd>lua require('telescope.builtin').commands()<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>l', [[<cmd>lua require'telescope'.extensions.ultisnips.ultisnips{}<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>l', [[<cmd>lua require'telescope'.extensions.ultisnips.ultisnips{}<cr>]], {})

-- api.nvim_set_keymap('', '<A-a>t', [[<cmd>lua require('telescope').extensions.packer.plugins(opts)<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>t', [[<cmd>lua require('telescope').extensions.packer.plugins(opts)<cr>]], {})
-- api.nvim_set_keymap('', '<A-a>2', [[<cmd>lua require('telescope').extensions.frecency.frecency()<cr>]], {})
-- api.nvim_set_keymap('!', '<A-a>2', [[<cmd>lua require('telescope').extensions.frecency.frecency()<cr>]], {})





--- ======= NVIM TREE ========
{
    name = 'nvim-tree - cwd',
    action = function() require'plugin/nvim-tree'.open(vim.fn.getcwd()) end,
    keymap = {{'n', '<space>ff', {}}} --, {'!', '<A-f>f', {}}}
  },
{

    name = 'nvim-tree - code library',
    action = function() require'plugin/nvim-tree'.open('/home/f1/cl') end,
    keymap = {{'n', '<space>fc', {}}} --, {'!', '<A-f>c', {}}}
  },
{
    name = 'nvim-tree - .dotfiles',
    action = function()   require'plugin/nvim-tree'.open('/home/f1/.dotfiles') end,
    keymap = {{'n', '<space>fd', {}}} --, {'!', '<A-f>d', {}}}
  },
{
    name = 'nvim-tree - plugins',
    action = function()  require'plugin/nvim-tree'.open(string.format('%s/site/pack/packer/opt', vim.fn.stdpath('data'))
) end,
    keymap = {{'n', '<space>fv', {}}} --, {'!', '<A-f>v', {}}}
  },
{
    name = 'nvim-tree - plugins manual',
    action = function()  require'plugin/nvim-tree'.open('/home/f1/code/obsidian/DEV') end,
    keymap = {{'n', '<space>fb', {}}} --, {'!', '<A-f>b', {}}}
  },
{
    name = 'nvim-tree - plugins me',
    action = function()  require'plugin/nvim-tree'.open(string.format('%s/plugins-me', vim.fn.stdpath('config'))) end,
    keymap = {{'n', '<space>fn', {}}} --, {'!', '<A-f>n', {}}}
  },









}









