local term = {}

local log = require("log1")

term.state = {}

term.last_editor_winnr = 1000

function term.new()
  vim.cmd("term")
  table.insert(term.state, 1, {
    tabnr = vim.api.nvim_get_current_tabpage(),
    winnr = vim.api.nvim_get_current_win(),
    bufnr = vim.api.nvim_get_current_buf(),
  })
  vim.cmd("startinsert")
end

local function is_term_or_editor_focused(c_winnr)
  for _, term in pairs(term.state) do
    if c_winnr == term.winnr then
      return true
    end
  end

  return false
end

local function get_current_tabpage_term()
  local c_tabnr = vim.api.vim_get_current_tabpage()

  local all_term_winnr = {}

  for _, term in pairs(term.state) do
    if c_tabnr == term.tabnr then
      table.insert(all_term_winnr, term.winnr)
    end
  end

  return all_term_winnr
end


local function should_cycle()

end

function term.focus_cycle()
  if vim.tbl_isempty(term.state) then return end

  c_winnr = vim.api.nvim_get_current_win()

  local is_term_or_editor_focused = is_term_or_editor_focused(c_winnr)

  -- all_term_winnr is constrained to current tabpage
  local all_term_winnr = get_current_tabpage_term()


  log.info(is_term_or_editor_focused, all_term_winnr)

  if is_term_or_editor_focused then
    for i, term_winnr in ipairs(all_term_winnr) do
      if c_winnr == term_winnr then
          log.info(#all_term_winnr, i)
        if #all_term_winnr == i then
          vim.api.nvim_set_current_win(term.last_editor_winnr)
          else
        vim.api.nvim_set_current_win(all_term_winnr[i + 1])
        end
      end
    end
  else
    term.last_editor_winnr = vim.deepcopy(c_winnr)
    vim.api.nvim_set_current_win(all_term_winnr[1])
  end
end


-- function term.bufnew()
-- -- trigerred everytime a new term buffer is created
-- log.info({
--     tabnr = vim.api.nvim_get_current_tabpage(),
--     winnr = vim.api.nvim_get_current_win(),
--     bufnr = vim.api.nvim_get_current_buf(),
--   })
-- log.info('bufnew')
-- end


-- when using bufunload & bufdelete, :q doesnt trigger, :Bdelete does trigger
-- bufwinleave triggers on both
function term.bufwinleave()
-- bufwinleave = before is removed from a window, get_current_win is window that just closed

-- log.info('bufunload')
-- log.info({
--     tabnr = vim.api.nvim_get_current_tabpage(),
--     winnr = vim.api.nvim_get_current_win(),
--     bufnr = vim.api.nvim_get_current_buf(),
--   })
--
--log.info(vim.api.nvim_get_current_buf())
log.info(vim.api.nvim_get_current_win())
local c_winnr = vim.api.nvim_get_current_win()

  for i, t in pairs(term.state) do
    if c_winnr == t.winnr then
      log.info(term.state, i)
      table.remove(term.state, i)
    end
  end
--log.info(term.state)
end


-- default behaviour:
-- :q <-- never deletes buffer, deletes window
-- :BDelete < -- deletes buffer, never deletes window
-- this autocmd, on :q will also delete buffer for term windows only

function term.exit_term()
  log.info('exit term trig')
local c_backslash = vim.api.nvim_replace_termcodes([[<C-\>]], true, false, true)
local c_n = vim.api.nvim_replace_termcodes('<C-n>', true, false, true)
vim.api.nvim_feedkeys(c_backslash, 'n', true)
vim.api.nvim_feedkeys(c_n, 'n', true)
end

return term


-- TODO: add to array on :term cmd
