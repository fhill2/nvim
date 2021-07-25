-- P = function(v)
--   print(vim.inspect(v))
--   return v
-- end

local M





function export_luatable_to_vimgvar(e, prevpath)
-- flattens a lua table into a vim g global variable for each key value it contains
  -- instead, ended up using vim.api.nvim_set_var('State', State) to save session

        for k,v in pairs(e) do
         --  lo('v is: ')
         -- lo(v)          
          if prevpath ~= nil then k = string.format('%s_%s', prevpath, k) end
          -- deepPrint if else start here
        if type(v) == 'table' and pcall(vim.tbl_is_empty, v) == true or type(v) ~= 'table' or vim.tbl_islist(v) == true then
        --  lo('DID NOT deep print')
             if vim.tbl_islist(v) == true then v = vim.inspect(v) end
            -- all variables end up here, so modify this to change behaviour
             --  print(string.format('vim.g.State.%s = %s', k, v)) 
             local k = string.format('State.%s', k)
             lo(string.format([[variable set: %s | %s]], k, v))
             vim.api.nvim_set_var(k, v)
             
        else 
      --  lo('DID deep print')
         export_luatable_to_vimgvar(v, k)       -- recursively repeat the same procedure
        end
      end
  
end

return M
