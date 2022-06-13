local action_state = require('telescope.actions.state')

require('telescope').setup{
  -- example of how to set defaults and mappings within telescope window
  --  defaults = {
  --      mappings = {
  --          i = {
  --              ["<c-b>"] = function() 
  --                print(vim.inspect(action_state.get_selected_entry()))
  --              end
  --          }
  --      }
  --  }
}

require('telescope').load_extension('fzf')

-- EXAMPLE of how to export functions
--local mappings = {
--
--}
--
--mappings.cur_buf = function()
--   local opts = require('telescope.themes').get_ivy()
--   require('telescope.builtin').current_buffer_fuzzy_find(opts)
--end
--
--return mappings

