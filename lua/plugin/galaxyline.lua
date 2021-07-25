local gl = require('galaxyline')
local utils = require('futil/utils')

local gls = gl.section

local colors = require('futil/colors').colors

local log1 = require('log1')
-- Local helper functions
local buffer_not_empty = function()
  -- had to be outside of any loaded lua file on init
  return not utils.is_buffer_empty() 
end

-- local is_buffer_empty = function()
--   -- Check whether the current buffer is empty
--   return vim.fn.empty(vim.fn.expand('%:t')) == 1
-- end

local mode_color = function()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green,
    c = colors.orange,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red,
    t = colors.green,
  }

  return mode_colors[vim.fn.mode()]
end

vim.cmd([[hi StatusLine guibg=]] .. colors.section_bg)

-- Left sidei
-- gls.left[1] = {
--   FirstElement = {
--     provider = function() return '▋' end,
--     highlight = { colors.cyan, colors.section_bg }
--   },
-- }


local function luapad_eval_check(current_winnr, current_buffnr)
 if current_winnr == fstate.btmwindow.luapad.winnr then
    if fstate.luapad.btmwindow_eval_on_change == true then
          return 'auto-ON'
          elseif fstate.luapad.btmwindow_eval_on_change == false then
            return 'auto-OFF'
          end
    
      elseif current_winnr ~= fstate.btmwindow.luapad.winnr then
    if fstate.luapad.editor_eval_on_change == true then

          return 'auto-ON'
          elseif fstate.luapad.editor_eval_on_change == false then
            return 'auto-OFF'
          end
      end 
end




gls.left[1] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        R = 'REPLACE',
        t = 'TERMINAL',
      }
        --log1.info(vim.fn.mode())
        vim.api.nvim_command('hi GalaxyViMode guifg='..
        mode_color())
      return alias[vim.fn.mode()]..' '
            
    end,
    highlight = { colors.bg, colors.bg },
    separator = "  ",
    separator_highlight = {colors.bg, colors.section_bg},
  },
}

gls.left[6] = {
  shellrepl = {
  provider = function()
      return require'shell-repl/statusline'.status()
  end,
  condition = function() if pcall(require'shell-repl/statusline'.status) == true then return true else return false end
end
},
}

gls.left[7] = {
    Luapadexist = {
    provider = function()
      --lo(pcall(require'luapad/statusline'.status))
       -- if pcall(require'luapad/statusline'.status) ~= true then return end
        local luapad_status = require'luapad/statusline'.status()
            if luapad_status == 'ok' then
                return 'LUAPAD'             
            else
                return ''
            end
          --  log1.info(luapad_status)
        end,
  condition = function()
      if pcall(require'luapad/statusline'.status) == true then return true else return false end
    end

    },
  }
gls.left[8] = {
    Luapadauto = {
    provider = function()
      local current_winnr = vim.api.nvim_get_current_win()
     local current_bufnr = vim.api.nvim_get_current_buf()
    local all_luapad_bufnr = require'plugin/luapad'.all_luapad_bufnr()

--lo('luapad_eval_check is:')
--lo(luapad_eval_check())

if vim.tbl_isempty(all_luapad_bufnr) == true then 
--lo('tbl is empty')
  return '' 
end
-- lo(vim.tbl_contains(all_luapad_bufnr, current_bufnr))

    if vim.tbl_contains(all_luapad_bufnr, current_bufnr) == true then
    return luapad_eval_check(current_winnr)
  --  return ''
                  elseif vim.tbl_contains(all_luapad_bufnr, current_bufnr) ~= true then
        return ''
        end

     end, -- end of provider
   condition = function() 
      
        if pcall(require'luapad/statusline'.status) == true then return true else return false end
    end

    },
 }
gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
  },
}
gls.left[4] = {
  FileName = {
    provider = { 'FileName'},
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator = " ",
    separator_highlight = {colors.section_bg, colors.bg},
  }
}
gls.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.section_bg}
  }
}
gls.left[13] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.orange,colors.section_bg},
  }
}
gls.left[15] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.section_bg},
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}
gls.left[16] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = ' 💡 ',
    highlight = {colors.blue,colors.section_bg},
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}
-- gls.left[16] = {
--   Test = {
--   provider = function() 
--       vim.g.countup = 1
--       print(vim.g.countup)
--       vim.g.countup = vim.g.countup + 1
--     end
--   }
-- }


gls.right[1] = {
  Cwd = {
    provider = function() return vim.fn.getcwd() end,
   -- icon = ' 💡 ',
    highlight = {colors.blue,colors.section_bg},
   -- separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}
