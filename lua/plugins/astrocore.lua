-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      -- set global limits for large files for disabling features like treesitter
      large_buf = { size = 1024 * 256, lines = 10000 },
      -- enable autopairs at start
      autopairs = false,
      -- enable completion at start
      cmp = true,
      -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      diagnostics_mode = 3,
      -- highlight URLs at start
      highlighturl = true,
      -- enable notifications at start
      notifications = true,
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        colorcolumn = { 80 },
        foldcolumn = "0",
        shiftwidth = 4,
        tabstop = 4,
        softtabstop = 4,
        scrolloff = 0,
        sidescrolloff = 4,
        cmdheight = 1,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file

        -- LSP docs should be prioritized
        -- TODO technically, this is needed for clojure buffers only and only
        --      when LSP is running
        ["conjure#mapping#doc_word"] = false,
        -- semantic tokens are preferred
        polyglot_disabled = { "gdscript" },
        -- for nvim lua to work with conjure
        ["conjure#extract#tree_sitter#enabled"] = true,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- extra git mappings
        ["<leader>gT"] = {
          function()
            require("agitator").git_time_machine({ use_current_win = true })
          end,
          desc = "Time machine"
        },

        ["<leader>gB"] = { ":ToggleBlame<cr>", desc = "Full-file blame" },

        -- Conjure descriptions
        ["<localleader>e"] = { desc = "Evaluate" },
        ["<localleader>ec"] = { desc = "Evaluate and comment" },
        ["<localleader>c"] = { desc = "Connect" },
        ["<localleader>g"] = { desc = "Goto" },
        ["<localleader>l"] = { desc = "Logs" },
        ["<localleader>r"] = { desc = "Refresh" },
        ["<localleader>s"] = { desc = "Session" },
        ["<localleader>t"] = { desc = "Test" },
        ["<localleader>v"] = { desc = "View" },

        -- vim-sexp
        ["<localleader>k"] = { name = "Paredit" },
        ["<localleader>kr"] = { "<Plug>(sexp_raise_list)", desc = "Raise list" },
        ["<localleader>kR"] = { "<Plug>(sexp_raise_element)", desc = "Raise element" },
        ["<localleader>kd"] = { "<Plug>(sexp_splice_list)", desc = "Drop list" },
        ["<localleader>kh"] = { "<Plug>(sexp_insert_at_list_head)", desc = "Insert at head" },
        ["<localleader>kj"] = { "<Plug>(sexp_capture_prev_element)", desc = "Slurp back" },
        ["<localleader>kk"] = { "<Plug>(sexp_capture_next_element)", desc = "Slurp front" },
        ["<localleader>kJ"] = { "<Plug>(sexp_emit_head_element)", desc = "Barf back" },
        ["<localleader>kK"] = { "<Plug>(sexp_emit_tail_element)", desc = "Barf front" },

        -- clojure tests
        ["<localleader>tt"] = { ":CcaNsJumpToAlternate<cr>", desc = "Jump to alternate" },
        ["<localleader>tf"] = { ":CcaNreplJumpToFailingCljTest<cr>", desc = "Jump to failed" },

        -- git co-authors
        ["<leader>fg"] = {
          function()
            require('telescope').extensions.githubcoauthors.coauthors()
          end,
          desc = "Find Co-Authors"
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
