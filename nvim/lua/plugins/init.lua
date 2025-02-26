-------------------------------------------------------
-- lua/plugins/init.lua
-- Now using Telescope instead of fzf,
-- and neotest instead of vim-test.
-------------------------------------------------------
-- override LSP diagnostic signs with nerd font icons
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {

  -- nvim-cmp & friends
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- vim-graphql
  { "jparise/vim-graphql" },

  -- vim-scripts/lightline
  { "vim-scripts/lightline" },

  -- Gitsigns plugin
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        -- signs = {
        -- 	add          = { text = "" },
        -- 	change       = { text = "" },
        -- 	delete       = { text = "" },
        -- 	topdelete    = { text = "" },
        -- 	changedelete = { text = "" },
        -- },
        -- You can enable inline blame with:
        current_line_blame = true, -- set to true if you want it on by default
        current_line_blame_opts = {
          delay = 300,
          virt_text_pos = "eol",
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Keymap to toggle line blame
          vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { buffer = bufnr })
        end,
      })
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<space>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        enabled = true,
        view_history = "messages",
      },
      cmdline = {
        opts = {
          position = {
            row = "30%",
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- vim-surround
  { "tpope/vim-surround" },

  -- vim-vinegar
  { "tpope/vim-vinegar" },

  -- vim-commentary
  { "tpope/vim-commentary" },

  -- vim-rhubarb
  { "tpope/vim-rhubarb" },

  -- vim-dispatch
  { "tpope/vim-dispatch" },

  -- CamelCaseMotion
  { "bkad/CamelCaseMotion" },

  -- vim-sneak
  { "justinmk/vim-sneak" },

  -- emmet-vim
  { "mattn/emmet-vim" },

  -- lightline-onedark
  { "hallzy/lightline-onedark" },

  -- vim-closetag
  { "alvan/vim-closetag" },

  -- nvim-remote-containers
  { "jamestthompson3/nvim-remote-containers" },

  -- asyncrun.vim
  { "skywind3000/asyncrun.vim" },

  -- vim-oscyank
  { "ojroques/vim-oscyank",                  branch = "main" },

  -- nvim-treesitter with playground
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
    opts = {
      ensure_installed = "all", -- or a list of languages like { "lua", "vim", "python" }
      highlight = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,     -- debounce time for highlighting nodes in the playground from source code
        persist_queries = false, -- whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
    opts = {
      ensure_installed = "all", -- or a list of languages like { "lua", "vim", "python" }
      highlight = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,     -- debounce time for highlighting nodes in the playground from source code
        persist_queries = false, -- whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- dressing.nvim
  { "stevearc/dressing.nvim" },

  -- plenary.nvim
  { "nvim-lua/plenary.nvim" },

  -- nui.nvim
  { "MunifTanjim/nui.nvim" },

  -- render-markdown.nvim
  { "MeanderingProgrammer/render-markdown.nvim" },

  -- nvim-web-devicons
  { "nvim-tree/nvim-web-devicons" },

  -- img-clip.nvim
  { "HakonHarnes/img-clip.nvim" },

  -- avante.nvim
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
  },

  -- neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "echasnovski/mini.pick",         -- optional
    },
    -- config = true,
    config = function()
      require("neogit").setup({
        kind = "split", -- Opens in a horizontal split
      })
    end,
  },

  -- null-ls & mason-null-ls integration
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "eslint_d", -- Linter for TypeScript/JavaScript
          "prettierd", -- Formatter for TypeScript/JavaScript
          "swiftlint", -- Linter for Swift
          "swiftformat", -- Formatter for Swift
          "shellcheck", -- Linter for Bash
          "shfmt",  -- Formatter for Bash
          "stylua", -- Formatter for Lua
          "luacheck", -- Linter for Lua
        },
        automatic_installation = true,
      })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- TypeScript / JavaScript
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
          -- Swift
          null_ls.builtins.formatting.swiftformat,
          null_ls.builtins.diagnostics.swiftlint,
          -- Bash
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.diagnostics.shellcheck,
          -- Lua
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.luacheck,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local formatting_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = formatting_group,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },

  -- snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      toggle = {
        which_key = true,
        notify = true,
      },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader>\\",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      -- -- Top Pickers & Explorer
      {
        "<space>o",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<space>B",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<space>g",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      {
        "<space>`",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<space>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      -- -- find
      -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<space>,",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      -- { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      {
        "<space>r",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- -- git
      -- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- -- Grep
      {
        "<space>l",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      -- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- -- search
      -- { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      -- { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      -- { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      -- { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      -- { "<space>i", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      -- { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      -- { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      {
        "<space>h",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      -- { "<space>i", function() Snacks.picker.icons() end, desc = "Icons" },
      -- { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      -- { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      -- { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      -- { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      -- { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      -- { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      -- { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      -- { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- -- LSP
      -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- -- Other
      -- { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      -- { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      -- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      -- { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      -- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      -- {
      --   "<leader>N",
      --   desc = "Neovim News",
      --   function()
      --     Snacks.win({
      --       file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
      --       width = 0.6,
      --       height = 0.6,
      --       wo = {
      --         spell = false,
      --         wrap = false,
      --         signcolumn = "yes",
      --         statuscolumn = " ",
      --         conceallevel = 3,
      --       },
      --     })
      --   end,
      -- }
    }, -- keys
  }, -- snacks

  -- telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  -- telescope-fzf-native.nvim
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  -- neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
  },

  -- lazygit.nvim
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  -- mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", -- TypeScript/JavaScript/React
          -- "gopls",       -- Go
          "bashls", -- Shell scripting
          "lua_ls", -- Lua
        },
      })
    end,
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        require("user.lsp_keymaps").setup(bufnr)
      end

      local servers = { "ts_ls", "sourcekit", "bashls", "lua_ls" }
      for _, server in ipairs(servers) do
        if server == "ts_ls" then
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
              preferences = {
                completeFunctionCalls = true,
                includeCompletionsWithSnippetText = true,
              },
            },
          })
        elseif server == "sourcekit" then
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "sourcekit-lsp" },
            filetypes = { "swift" },
          })
        else
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
      end
    end,
  },
}

