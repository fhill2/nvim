local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local previewers = require'telescope.previewers'
local Previewer = require('telescope.previewers.previewer')
local log = require'log1'
local if_nil = vim.F.if_nil
local state = require('telescope.state')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local Path = require('plenary.path')
--- 


-- always route autocmd to my own custom function
-- vim.cmd([[autocmd User TelescopeFindPre :lua require('plugin.telescope').apply_autocmd()]])


require('telescope').setup{
defaults = {
--    mappings = {
--     i = {
-- ["<Esc>"] = function() require'log1'.info('esc trig insert') end,
-- ["<C-q>"] = false
--   },
--   n = {
-- ["<C-q>"] = false
-- ["<Esc>"] = function() require'log1'.info('esc trig normal') end
--   }
-- },
  --  mappings = {
  --     i = {
  --       -- To disable a keymap, put [map] = false
  --       -- So, to not map "<C-n>", just put
  --       ["<c-x>"] = false,
  --     },
  -- },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = true,
   -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
   -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    borderchars = {
      preview =  { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt =  { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results =  { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
 sorting_strategy = "ascending",
 layout_strategy = "horizontal",
  },
  -- pickers = {
  --   find_files = {
  --     follow = true,
  --     hidden = true,
  --     find_command = {'fd', '-HI', '--type', 'f', '-L'},
  --   },
  -- },
 extensions = {
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      workspaces = {
        ["conf"]    = "/home/f1/.config",
        ["data"]    = "/home/f1/.local/nvim"
      },
bookmarks = {
      -- Available: 'brave', 'google_chrome', 'safari', 'firefox', 'firefox_dev'
      selected_browser = 'brave',

      -- Either provide a shell command to open the URL
      url_open_command = 'open',

      -- Or provide the plugin name which is already installed
      -- Available: 'vim_external', 'open_browser'
      url_open_plugin = nil,
      firefox_profile_name = nil,
    },
    },
fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        }
  },
 }


require('telescope').load_extension('fzy_native')
--require('telescope').load_extension('snippets')
require'telescope'.load_extension("cheat")
--require('telescope').load_extension('ultisnips')
--require('telescope').load_extension('livetablelogger')
--require('telescope').load_extension('floating')
--require('telescope').load_extension('frecency')
require('telescope').load_extension('bookmarks')


-- =================== PERSONAL CONFIG ====================



-- additional per picker mappings

-- local file_browser_mappings = function(_, map)
-- map('n', '<CR>', actions.my_cool_custom_action)
--   return true
-- end

-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod


local my_actions = {}

function my_actions.live_grep_or_edit(prompt_bufnr) 
  local telescope = require'plugin/telescope'
  local entry = action_state.get_selected_entry()
  local fp = Path:new(string.format('%s/%s', entry.cwd, entry.ordinal)) 
fp:normalize()
if fp:is_file() then 
action_set.edit(prompt_bufnr, "edit")   
elseif fp:is_dir() then
telescope.live_grep({ cwd = fp.filename})
else
print('path isnt dir or file')
end
end

function my_actions.find_files(prompt_bufnr)
local telescope = require'plugin/telescope'
local entry = action_state.get_selected_entry()
local cwd = string.format('%s/%s', entry.cwd, entry.ordinal)
telescope.find_files({ cwd = cwd })
end



transform_mod(my_actions)




-- action_set.select:enhance({
--       pre = function()
--                  -- Will run before actions.select_default
--       end,
--       post = function()
--           -- Will run after actions.select_default
--       end,
--     })


-- ================= TELESCOPE MANAGER ==================

local telescope = {}


telescope.manager = {}

--- @persistent: saves picker to plugin/telescope.telemanager when creating


-- save temp data
telescope.settings = {
-- last_editor_winnr saved here
-- c_type
}

-- gets passed into telescope for creation
telescope.persistent = {
enabled = false,
preview_pane_width = 80, -- if floating = true, width of standard preview pane
floating_preview = false, -- whether to spawn persistent with normal floating window
}



telescope.get_current_focus = function(name)
  -- only works for persistent
  c_winnr = vim.api.nvim_get_current_win()
  -- persistent status
  local persistent_winnr = state.get_status(telescope.manager[name]).prompt_win
  log.info(c_winnr, persistent_winnr)
  if c_winnr == persistent_winnr then return 'persistent' else return 'editor' end
end



telescope.get_picker = function(name)
local prompt_bufnr = telescope.manager[name]
return state.get_status(prompt_bufnr)
end


telescope.close = function(name)
   log.info('AT TELESCOPE CLOSE')
 local picker = telescope.get_picker(name)

 local status = state.get_status(telescope.manager[name])


  local picker = status.picker

  if picker.sorter then
    picker.sorter:_destroy()
  end

  if picker.previewer then
    picker.previewer:teardown()
  end

  picker.close_windows(status)

  if name == 'persistent' then
    telescope.manager.persistent = nil
  end

 
end


-- toggle for persistent
telescope.focus = function(name)
  log.info('got here 1')
if not telescope.manager[name] then return end

local c_focus = telescope.get_current_focus('persistent')
log.info(c_focus)
if c_focus == 'persistent' then
  log.info('got here')
  vim.api.nvim_set_current_win(telescope.settings.last_editor_winnr)  
else
  telescope.settings.last_editor_winnr = vim.api.nvim_get_current_win()

local picker = telescope.get_picker(name)
vim.api.nvim_set_current_win(picker.prompt_win)
local prompt = vim.api.nvim_buf_get_lines(picker.prompt_buf, 0, 1, false)[1]
vim.api.nvim_win_set_cursor(picker.prompt_win, { 1, #prompt})
local mode = vim.api.nvim_get_mode().mode

if mode == 'n' then
vim.api.nvim_feedkeys('i', 'n', false)
end

end
end

--to assign prev window
-- local function get_all_picker_preview_bufnr()
--   local all_picker_preview_bufnr = {}
--   for name, _ in pairs(telescope.manager) do
--   table.insert(all_picker_preview_bufnr, telescope.get_picker(name).preview_bufnr)
--   end
--   log.info('all prompt_winnr is: ', all_picker_preview_bufnr)
--   return all_picker_preview_bufnr

-- end



local function get_all_picker_preview_winnr()
  local all_picker_preview_winnr = {}
  for name, _ in pairs(telescope.manager) do
  table.insert(all_picker_preview_winnr, telescope.get_picker(name).preview_win)
  end
 -- log.info('all prompt_winnr is: ', all_picker_preview_bufnr)
  return all_picker_preview_winnr

end



local function set_last_editor_winnr()
c_floating_or_editor = vim.tbl_contains(vim.tbl_keys(vim.api.nvim_win_get_config(vim.api.nvim_get_current_win())), "anchor")

  if not c_floating_or_editor then 
  -- it could be an editor window but the persistant standard buffer
  if vim.tbl_isempty(get_all_picker_preview_winnr()) then 
    log.info('set last_editor 1', vim.api.nvim_get_current_win())
   telescope.settings.last_editor_winnr = vim.api.nvim_get_current_win()
  else
    if not vim.tbl_contains(get_all_picker_preview_winnr(), vim.api.nvim_get_current_win()) then
      log.info('set last_edit_winnr 2: ', vim.api.nvim_get_current_win())
  telescope.settings.last_editor_winnr = vim.api.nvim_get_current_win()
  end
end
end
log.info('PERSISTENT last_editor_winnr is: ', telescope.settings.last_editor_winnr)

end

telescope.pre_launch_persistent = function(type)
 -- telescope.settings.c_type = type
 -- telescope.persistent.type = type

set_last_editor_winnr()
 
 telescope.persistent.enabled = true
    if telescope.manager.persistent then 
        telescope.close('persistent')
end
    
end

telescope.pre_launch_floating = function(type)
 -- telescope.settings.c_type = type
  log.info(telescope.settings.c_type)
  set_last_editor_winnr()
 telescope.persistent.enabled = false
end

-- use normal floating window
telescope.find_files = function(opts)
    telescope.pre_launch_floating('Find Files')

 

 -- builtin.find_files(themes.get_dropdown{ layout_strategy = 'cursor'})
 -- local returned = builtin.find_files(themes.get_cursor({layout_config = {width = 140}}))
  --builtin.find_files(themes.get_btm()) -- then make btm_minimal layout strat always center and pin to btm
  builtin.find_files(themes.get_editor_scoped({ 
    name = 'floating', 
    cwd = opts.cwd,
   find_command = {'fd', '-HI', '--type', 'f', '-L'}, -- necessary
   last_editor_winnr = telescope.settings.last_editor_winnr,
   prompt_title = string.format('Find Files %s', opts.cwd),
 --    attach_mappings = function(_, map)
 -- -- map('i', '<c-d>', actions.git_deleite_branch) -- this action already exist
 --  map('i', '<c-d>', actions.move_selection_previous) 
 --  map('i', '<c-d>', actions.move_selection_previous) 
 --  return true
 --    end
    
--- fd i dont think i used
---{'fd', '-H', '--type', 'd', '--type', 'l', '-L'},

  }))
end

telescope.buffers = function(opts)
      telescope.pre_launch_floating('Buffers')

   builtin.buffers({
  theme = themes.get_btm{ 
    name = 'floating', 
    layout_strategy = 'cursor',
    last_editor_winnr = telescope.settings.last_editor_winnr,

  }})
end

telescope.file_browser = function(opts)
  telescope.pre_launch_persistent('File Browser')
  log.info('live_grep telescope settings persistent is: ', telescope.settings.last_editor_winnr)

  -- use persistent but normal floating window
  telescope.persistent.floating_preview = true

   builtin.file_browser(themes.get_btm{
    name = 'persistent', 
    persistent = telescope.persistent,
    cwd = opts.cwd,
    last_editor_winnr = telescope.settings.last_editor_winnr,
    prompt_title = string.format('File Browser %s', opts.cwd),

    attach_mappings = function(_, map)
   -- map('i', '<c-d>', actions.git_deleite_branch) -- this action already exist
  map('i', '<F17>', my_actions.live_grep_or_edit) -- this action already exist
  map('i', '<A-a>a', my_actions.find_files)
  
  -- For more actions look at lua/telescope/actions/init.lua
  return true
end


--file_browser_mappings
    })
end


-- use custom persistent standard preview window

telescope.live_grep = function(opts)
    log.info(telescope.persistent)
    telescope.pre_launch_persistent('Live Grep')
   builtin.live_grep(themes.get_btm{
    name = 'persistent', 
    persistent = telescope.persistent,
    cwd = opts.cwd,
    prompt_title = string.format('Live Grep %s', opts.cwd),
    last_editor_winnr = telescope.settings.last_editor_winnr,

    })
end



-- default wrapper for normal :Te commands - wraps everything in btm theme by default
telescope.load_command = function(args)
telescope.pre_launch_floating()
telescope.persistent.enabled = false
builtin[args](themes.get_btm({ 
  name = 'floating',
   last_editor_winnr = telescope.settings.last_editor_winnr,
  }))
end

-- same but for lua
local telescope_mt = {}
telescope_mt.__index = function(self, key, value)
  return function() self.load_command(key) end
end

setmetatable(telescope, telescope_mt)

--- new telescope command that wraps every picker in ivy
vim.cmd([[command! -nargs=* -complete=custom,s:telescope_complete Te    lua require('plugin.telescope').load_command(<f-args>)]])




function themes.get_editor_scoped(opts)
  
  opts = opts or {}
  log.info(telescope.settings.c_type)

  return vim.tbl_deep_extend("force", {
    theme = "editor_scoped",
    preview = true,
    sorting_strategy = "ascending",
    --prompt_title = "",
    --preview_title = "asd fruits",
    results_title = " ",
    layout_config = {
      height = 20,
      preview_cutoff = 20, -- NEEDED for editor_vertical
    },
    layout_strategy = "editor_vertical",
   -- border = true,
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      ---results = { "a", "b", "c", "d", "e", "f", "g", "h" },
      --preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      preview = { "─", " ", " ", " ", "─", "─", " ", " "},
      }
     }, opts)


end

function themes.get_btm(opts)
  -- modification of get_ivy
  opts = opts or {}

     local layout_strategy
      if telescope.persistent.enabled and telescope.persistent.floating_preview then
        layout_strategy = "bottom_pane"
      else 
        layout_strategy = 'btm_standard_preview'
      end

      local layout_config = {
      height = 20,
      }

  if not telescope.persistent.floating_preview then
    layout_config.preview_pane_width = telescope.persistent.preview_pane_width
  end

  return vim.tbl_deep_extend("force", {
    theme = 'btm',
    sorting_strategy = "ascending",
    prompt_title = string.format('%s %s', telescope.settings.c_type, opts.cwd),
    --preview_title = "",
    --results_title = "",
    layout_config = layout_config,
    layout_strategy = layout_strategy,
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      ---results = { "a", "b", "c", "d", "e", "f", "g", "h" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    },
  }, opts)
end






















return telescope



 -- set last_editor_winnr 
  -- local c_win = vim.api.nvim_get_current_win()
  -- -- is current win already on a telescope window
  --  if not all_prompt_winnr or vim.tbl_isempty(telescope.manager) then 
  --   -- no active telescope window
  --  telescope.settings.last_editor_winnr = c_win
  -- else
  --   local all_prompt_winnr = get_all_prompt_winnr()

  --   local match = false
  --     for _, prompt_winnr in ipairs(all_prompt_winnr) do
  --       if prompt_winnr == c_win then match = true end
  --     end

  --     if not match then telescope.settings.last_editor_winnr = c_win end
  -- end






-- teletest.move_preview = function()
-- log.info('move preview trig')
-- local picker = get_picker()


-- -- toggle
-- if toggle == nil then
--   log.info('toggle setup')
--   toggle = false

--   -- 
--   c_opts = vim.api.nvim_win_get_config(picker.preview_win)
-- c_border_opts =  vim.api.nvim_win_get_config(picker.preview_border_win)

-- new_opts = vim.tbl_deep_extend('force', c_opts, { col = vim.o.columns - c_opts.width - 1 })
-- new_border_opts = vim.tbl_deep_extend('force', c_border_opts, { col = vim.o.columns - c_border_opts.width - 1 })

--   end



