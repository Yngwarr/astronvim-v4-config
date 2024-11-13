-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- wraps more actions with repeat
  { "tpope/vim-repeat", lazy = false },
  -- must have for surrounding regions with braces
  { "tpope/vim-surround", lazy = false },
  -- paredit-style editing
  { "yngwarr/vim-sexp", lazy = false },
  -- more filetype coloring
  { "sheerun/vim-polyglot", lazy = false },
  -- my favorite theme adaptation for nvim
  {
    "yngwarr/jellybeans-nvim",
    lazy = false,
    dependencies = { "rktjmp/lush.nvim" }
  },
  -- a local copy for tweaking
  -- {
  --   dir = '/home/igor/naboo/vim/jellybeans-nvim/',
  --   lazy = false,
  --   dependencies = { "rktjmp/lush.nvim" }
  -- },
  -- I use it for git time machine
  { "emmanueltouzery/agitator.nvim", lazy = false },
  -- strips extra spaces
  {
    "cappyzawa/trim.nvim",
    lazy = false,
    opts = {
      trim_last_line = false,
      trim_first_line = false
    }
  },
  -- narrow region (doesn't play nice with LSPs, useful nontheless)
  { "chrisbra/NrrwRgn", lazy = false },
  -- full-file blame
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup()
    end
  },
  -- to work with databases directly from vim
  { "tpope/vim-dadbod", lazy = false },
  {
    "petertriho/cmp-git",
    lazy = false,
    config = function()
      -- adds a github integration for issue number autocomplete
      require("cmp").setup.filetype({ "gitcommit" }, { sources = { { name = "git" } }})
      require("cmp_git").setup()
    end,
  },
  -- to easily add co-authors
  {
    "cwebster2/github-coauthors.nvim",
    lazy = false,
    config = function()
      require('telescope').load_extension('githubcoauthors')
    end
  },
  -- extra options for running tests in clojure
  {
    "https://gitlab.com/invertisment/conjure-clj-additions-cider-nrepl-mw",
    ft = { "clojure" },
  },
  -- REPL integration
  {
    "Olical/conjure",
    -- load plugin on filetypes
    ft = { "clojure", "lua" },
    init = function()
      vim.g["conjure#log#hud#width"] = 1
      vim.g["conjure#log#hud#enabled"] = false
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#botright"] = true
      vim.g["conjure#extract#context_header_lines"] = 100
      vim.g["conjure#eval#comment_prefix"] = ";;"
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = nil
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
      vim.g["conjure#client#clojure#nrepl#test#runner"] = "kaocha"
      -- vim.g["conjure#"]

      vim.api.nvim_create_autocmd("BufNewFile", {
        group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
        pattern = { "conjure-log-*" },
        callback = function() vim.diagnostic.disable(0) end,
        desc = "Conjure Log disable LSP diagnostics",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("comment_config", { clear = true }),
        pattern = { "clojure" },
        callback = function() vim.bo.commentstring = ";; %s" end,
        desc = "Lisp style line comment",
      })
    end,
  },

  -- a command to colorize the current buffer according to the terminal's
  -- control sequences
  {
    "m00qek/baleia.nvim",
    version = "*",
    lazy = false,
    config = function()
      vim.g.baleia = require("baleia").setup({ })

      -- Command to colorize the current buffer
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        vim.g.baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      -- Command to show logs
      vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
    end,
  },

  -- :ToggleDiag to turn diagnostics off when they're too noizy
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    lazy = false,
    config = function()
      require('toggle_lsp_diagnostics').init()
    end
  },

  -- show all diagnostics in one window to read them easier
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "            _.._   _..---.",
        "         .-\"    ;-\"       \\",
        "        /      /           |",
        "       |      |       _=   |",
        "       ;   _.-'\\__.-')     |",
        "        `-'      |   |    ;",
        "                 |  /;   /      _,",
        "               .-.;.-=-./-\"\"-.-` _`",
        "              /   |     \\     \\-` `,",
        "             |    |      |     |",
        "             |____|______|     |",
        "              \\0 / \\0   /      /",
        "           .--.-\"\"-.`--'     .'",
        "          (#   )          ,  \\",
        "          ('--'          /\\`  \\",
        "           \\       ,,  .'      \\",
        "            `-._    _.'\\        \\",
        "                `\"\"`    \\        \\",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  -- I have so many escape buttons on my keyboard, why would I need it?
  { "max397574/better-escape.nvim", enabled = false },
  -- I prefer to place my pairs by hand
  { "windwp/nvim-autopairs", enabled = false },
  -- the same is true for autotags
  { "windwp/nvim-ts-autotag", enabled = false },
  -- nice, but adds visual clutter in clojure
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- until I figure out how to change underline to highlight
  { "RRethy/vim-illuminate", enabled = false },
  -- too bright for my taste
  { "folke/todo-comments.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
}
