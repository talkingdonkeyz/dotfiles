return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },

    -- pull in your options table
    opts = function()
      return require "configs.null-ls"
    end,

    -- call setup with those options
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      local tools = {
        "clangd",
        "elixir-ls",
        "rust-analyzer",
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "prisma-language-server",
        "eslint-lsp",
        "prettier",
        "marksman",
      }
      vim.list_extend(opts.ensure_installed, tools)
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      require("configs.copilot").setup()
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    cmd = "NoNeckPain",
    opts = {
      width = 100,
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      win_options = {
        conceallevel = {
          default = 1,
          rendered = 2,
        },
      },
    },
  },

  {
    "kawre/leetcode.nvim",
    lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1),
    build = ":TSUpdate html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      arg = "leetcode.nvim",
      plugins = { non_standalone = false },
      picker = { provider = "telescope" },
      logging = true,
      lang = "elixir", -- default language set to Elixir
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "johannww/tts.nvim",
    cmd = { "TTS", "TTSFile" },
    keys = {
      { "<leader>rs", ":'<,'>TTS<cr>", mode = "v", desc = "Read selection aloud" },
    },
    opts = {
      backend = "edge",
      languages_to_voice = {
        edge = {
          ["en"] = "en-GB-RyanNeural",
        },
      },
    },
    config = function(_, opts)
      -- Point the backend script at the tts venv python
      local venv_python = vim.fn.expand("~/.local/share/nvim/tts-venv/bin/python3")
      local plugin_dir = vim.fn.stdpath("data") .. "/lazy/tts.nvim/"
      local script = plugin_dir .. "backends/edge.py"
      -- Patch the shebang to use the venv python
      local lines = vim.fn.readfile(script)
      if lines[1] ~= "#!" .. venv_python then
        lines[1] = "#!" .. venv_python
        vim.fn.writefile(lines, script)
      end
      require("tts-nvim").setup(opts)
    end,
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<leader>lo", "<cmd>AerialToggle<cr>", desc = "Outline" },
    },
    opts = {
      layout = {
        default_direction = "left",
        min_width = 30,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "elixir", "heex",
        "markdown", "markdown_inline",
      },
    },
  },
}
