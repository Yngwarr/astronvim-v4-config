-- Sketch is for the situation when I need a quick buffer to dump some info to
-- and I don't want to go to my sandbox repository myself.
--
-- USAGE
--  :Sketch — opens a dialog where you can choose a file interactively
--  :Sketch json — opens a file with a given type, creates if necessary
--  :Sketch something.json — opens a file called 'tmp_something.json'

local sandbox_path = '/home/igor/naboo/sandbox'
local sandbox_prefix = 'tmp'

vim.api.nvim_create_user_command("Sketch", function (opts)
  local arg = opts.fargs[1]

  if arg == nil then
    -- :Sketch
    require('telescope.builtin').find_files({
      prompt_title = 'Sketchbook',
      results_title = '',
      preview_title = '',
      cwd = sandbox_path,
      search_file = sandbox_prefix,
      default_text = opts.fargs[1]
    })
  else
    local arg_split = vim.fn.split(arg, '\\.')
    local file_name = nil

    if vim.fn.len(arg_split) == 1 then
      file_name = sandbox_prefix .. '.' .. arg_split[1]
    else
      file_name = sandbox_prefix .. '_' .. arg_split[1] .. '.'
          .. vim.fn.join(vim.fn.slice(arg_split, 1), '.')
    end

    vim.api.nvim_cmd({
      cmd = "e",
      args = { sandbox_path .. '/' .. file_name }
    }, {})
  end
end, { nargs = '?' })
