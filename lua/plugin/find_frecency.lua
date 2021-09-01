local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local utils = require('telescope.utils')
local conf = require('telescope.config').values
local entry_display = require'telescope.pickers.entry_display'
local db_client = require'telescope._extensions.frecency.db_client'
local sorters = require'telescope.sorters'
local os_home       = vim.loop.os_homedir()
local os_path_sep   = utils.get_separator()


local find_frecency = function(opts)

-- CHANGE
local cwd = opts.cwd
assert(cwd, 'you forgot to pass in a cwd')
local find_command = {'fd', '-HI', '--type', 'f', '-L', '-a'} -- -a to output absolute paths to be compared with frecency db


  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
  end

local scores = db_client.get_file_scores(false, opts.cwd)

local state = {
picker = {},
finder = {}
}

local function finder_entry_maker(line)
local rank
    -- this will slow things down but im not sure of a better way??
      for _, score in ipairs(scores) do
        if line == score.filename then
        -- both paths are absolute when compared
        rank = score.score 
               break end
     end
       if not rank then rank = 0 end

return { score = rank, filename = line}
end


-- does this need to be changed? finder started before picker so results can be accessed in on_input_filter_cb
state.finder = finders.new_oneshot_job(find_command, { cwd = opts.cwd, entry_maker = finder_entry_maker })
state.finder(_, function(line) return line end, function() end)




  local displayer = entry_display.create {
    separator = "",
    hl_chars = {[os_path_sep] = "TelescopePathSeparator"},
      items = {
      {width = 4, left_justify = true},
      {remaining = true},
    }
  }


  local make_display = function(entry)
local display_items = {{entry.score, "TelescopeFrecencyScores"}, {entry.filename, ""}}
return displayer({entry.score, entry.filename})
  end



local picker_entry_maker = function(entry)
    return {
      filename = entry.filename,
      display  = make_display,
      ordinal  = entry.filename,
      name     = entry.filename,
      score    = entry.score
    }
  end

-- might need to improve? currently picker shows random amount of results on startup. could change to showing only indexed files in the cwd.
state.picker = pickers.new(opts, {
    prompt_title = 'Find Files',
    on_input_filter_cb = function(query_text)
      local results = state.finder.results
      table.sort(results, function(a, b) return a.score > b.score end)
     local new_finder = finders.new_table {
          results     = results,
          entry_maker = picker_entry_maker
        }
    return { prompt = query_text, updated_finder = new_finder}
    end,


    finder = finders.new_table {
      results     = state.finder.results,
      entry_maker = picker_entry_maker
    },
      previewer = conf.file_previewer(opts),
      sorter = sorters.get_substr_matcher(opts)
 
  })

state.picker:find()
end


return {
  find_frecency = find_frecency

}

