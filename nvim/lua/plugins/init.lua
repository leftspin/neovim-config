-------------------------------------------------------
-- lua/plugins/init.lua
-- Now using Telescope instead of fzf,
-- and neotest instead of vim-test.
-------------------------------------------------------
return {
  -- 1) Coc.nvim
  { "neoclide/coc.nvim", branch = "release" },

  -- 2) vim-graphql
  { "jparise/vim-graphql" },

  -- 3) GitHub Copilot
  { "github/copilot.vim" },

  -- 4) APZelos/blamer.nvim
  -- REMOVED

  -- 5) vim-scripts/lightline
  { "vim-scripts/lightline" },

  -- Gitsigns plugin
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
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

  -- 6) vim-startify
  { "mhinz/vim-startify" },

  -- 7) vim-gutentags
  { "ludovicchabant/vim-gutentags" },

  -- 8) tpope/vim-surround
  { "tpope/vim-surround" },

  -- 9) tpope/vim-vinegar
  { "tpope/vim-vinegar" },

  -- 10) neogit (Modern, Magit-inspired Git interface for Neovim)
  { "NeogitOrg/neogit" },
  -- 11) gp.nvim (AI-powered commit message generator)
  { "robitx/gp.nvim",
    cmd = { "WriteGitCommitMessage" },
    ft = "gitcommit",
    opts = {},
  },

  -- 11) tpope/vim-commentary
  { "tpope/vim-commentary" },

  -- 12) tpope/vim-rhubarb
  { "tpope/vim-rhubarb" },

  -- 13) tpope/vim-dispatch
  { "tpope/vim-dispatch" },

  -- 14) bkad/CamelCaseMotion
  { "bkad/CamelCaseMotion" },

  -- 17) justinmk/vim-sneak
  { "justinmk/vim-sneak" },

  -- 18) mattn/emmet-vim
  { "mattn/emmet-vim" },

  -- 19) hallzy/lightline-onedark
  { "hallzy/lightline-onedark" },

  -- 20) alvan/vim-closetag
  { "alvan/vim-closetag" },

  -- 21) airblade/vim-gitgutter
  { "airblade/vim-gitgutter" },

  -- 22) jamestthompson3/nvim-remote-containers
  { "jamestthompson3/nvim-remote-containers" },

  -- 24) asyncrun.vim
  { "skywind3000/asyncrun.vim" },

  -- 25) vim-oscyank
  { "ojroques/vim-oscyank", branch = "main" },

  -- 26) neoscroll.nvim
  { "karb94/neoscroll.nvim" },

  -- 27) indentLine
  { "Yggdroot/indentLine" },

  -- 28) nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- 29) dressing.nvim
  { "stevearc/dressing.nvim" },

  -- 30) plenary.nvim
  { "nvim-lua/plenary.nvim" },

  -- 31) nui.nvim
  { "MunifTanjim/nui.nvim" },

  -- 32) render-markdown.nvim
  { "MeanderingProgrammer/render-markdown.nvim" },

  -- 33) nvim-cmp
  { "hrsh7th/nvim-cmp" },

  -- 34) nvim-web-devicons
  { "nvim-tree/nvim-web-devicons" },

  -- 35) img-clip.nvim
  { "HakonHarnes/img-clip.nvim" },

  -- 36) copilot.lua (disabled)
  { "zbirenbaum/copilot.lua", enabled = false },

  -- 37) avante.nvim
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make"
  },

  -----------------------------------------------------------------------
  -- ADD TELESCOPE + FZF NATIVE
  -----------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
  },

  -----------------------------------------------------------------------
  -- ADD NEOTEST
  -----------------------------------------------------------------------
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
}