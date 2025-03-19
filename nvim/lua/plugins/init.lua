-------------------------------------------------------
-- lua/plugins/init.lua
-------------------------------------------------------

-- Diagnostic signs (the old-school diagnostics config, in case there's old apps that use this)
local signs = { Error = "\u{EA87}", Warn = "\u{F071}", Info = "\u{F449}", Hint = "\u{F400}" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostics to use a rounded border for floating windows (the new way to do this)
vim.diagnostic.config({
	float = {
		border = "rounded", -- Use a rounded border for diagnostics
		source = "if_many", -- Display diagnostic source if multiple diagnostics are present
		header = "", -- No header in the popup
		prefix = "", -- No prefix for each diagnostic message
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " " .. signs.Error,
			[vim.diagnostic.severity.WARN] = " " .. signs.Warn,
			[vim.diagnostic.severity.INFO] = " " .. signs.Info,
			[vim.diagnostic.severity.HINT] = " " .. signs.Hint,
		},
	},
})

-- LSP keymaps are now defined in lua/user/keymaps.lua

return {

	-- nvim-cmp & friends
	-- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- https://github.com/hrsh7th/cmp-nvim-lsp
			"hrsh7th/cmp-buffer", -- https://github.com/hrsh7th/cmp-buffer
			"hrsh7th/cmp-path", -- https://github.com/hrsh7th/cmp-path
			"hrsh7th/cmp-cmdline", -- https://github.com/hrsh7th/cmp-cmdline

			"L3MON4D3/LuaSnip", -- https://github.com/L3MON4D3/LuaSnip
			"saadparwaiz1/cmp_luasnip", -- https://github.com/saadparwaiz1/cmp_luasnip
			"rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
		},
		config = function()
			require("user.plugin_config.nvim-cmp").setup()
		end,
	},

	-- ray-x/lsp_signature.nvim
	-- https://github.com/ray-x/lsp_signature.nvim
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			local ok, lsp_signature = pcall(require, "lsp_signature")
			if not ok then
				vim.notify("[lsp_signature] failed to load.", vim.log.levels.ERROR)
				return
			end
			lsp_signature.setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
				floating_window = true,
				hint_enable = true, -- show parameter hints
				hint_prefix = " ",
			})
		end,
	},

	-- vim-graphql
	-- https://github.com/jparise/vim-graphql
	{ "jparise/vim-graphql" },

	-- lualine.nvim - Better statusline with current working directory display
	-- https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("user.plugin_config.lualine")
		end,
	},

	-- Gitsigns plugin
	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
			if not gitsigns_ok then
				vim.notify("[gitsigns] failed to load.", vim.log.levels.ERROR)
				return
			end
			gitsigns.setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 300,
					virt_text_pos = "eol",
				},
				on_attach = function(_)
					-- Keybindings for gitsigns are now defined in lua/user/keymaps.lua
				end,
			})
		end,
	},

	-- which-key
	-- https://github.com/folke/which-key.nvim
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- Keybindings for which-key are now defined in lua/user/keymaps.lua
	},

	-- noice.nvim
	-- https://github.com/leftspin/noice.nvim (using personal fork)
	{
		"leftspin/noice.nvim",
		version = "*", -- fetch the latest stable version
		lazy = false, -- load early, no lazy/event
		config = function()
			require("user.plugin_config.noice").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim", -- https://github.com/MunifTanjim/nui.nvim
			"rcarriga/nvim-notify", -- https://github.com/rcarriga/nvim-notify
		},
	},

	-- vim-surround
	-- https://github.com/tpope/vim-surround
	{ "tpope/vim-surround" },

	-- vim-vinegar
	-- https://github.com/tpope/vim-vinegar
	{ "tpope/vim-vinegar" },

	-- vim-rhubarb
	-- https://github.com/tpope/vim-rhubarb
	{ "tpope/vim-rhubarb" },

	-- CamelCaseMotion
	-- https://github.com/bkad/CamelCaseMotion
	{ "bkad/CamelCaseMotion" },

	-- vim-sneak
	-- https://github.com/justinmk/vim-sneak
	{ "justinmk/vim-sneak" },

	-- emmet-vim
	-- https://github.com/mattn/emmet-vim
	{ "mattn/emmet-vim" },

	-- vim-closetag
	-- https://github.com/alvan/vim-closetag
	{ "alvan/vim-closetag" },

	-- nvim-remote-containers
	-- https://github.com/jamestthompson3/nvim-remote-containers
	{ "jamestthompson3/nvim-remote-containers" },

	-- asyncrun.vim
	-- https://github.com/skywind3000/asyncrun.vim
	{ "skywind3000/asyncrun.vim" },

	-- vim-oscyank
	-- https://github.com/ojroques/vim-oscyank
	{ "ojroques/vim-oscyank", branch = "main" },

	-- nvim-treesitter with playground
	-- https://github.com/nvim-treesitter/nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/playground" }, -- https://github.com/nvim-treesitter/playground
		config = function()
			require("user.plugin_config.treesitter").setup()
		end,
	},

	-- dressing.nvim
	-- https://github.com/stevearc/dressing.nvim
	{ "stevearc/dressing.nvim" },

	-- plenary.nvim
	-- https://github.com/nvim-lua/plenary.nvim
	{ "nvim-lua/plenary.nvim" },

	-- nui.nvim
	-- https://github.com/MunifTanjim/nui.nvim
	{ "MunifTanjim/nui.nvim" },

	-- render-markdown.nvim
	-- https://github.com/MeanderingProgrammer/render-markdown.nvim
	{ "MeanderingProgrammer/render-markdown.nvim" },

	-- nvim-web-devicons
	-- https://github.com/nvim-tree/nvim-web-devicons
	{ "nvim-tree/nvim-web-devicons" },

	-- img-clip.nvim
	-- https://github.com/HakonHarnes/img-clip.nvim
	{ "HakonHarnes/img-clip.nvim" },

	-- avante.nvim
	-- https://github.com/yetone/avante.nvim
	{
		"yetone/avante.nvim",
		branch = "main",
		build = "make",
	},

	-- neogit
	-- https://github.com/NeogitOrg/neogit
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
			"sindrets/diffview.nvim", -- https://github.com/sindrets/diffview.nvim
			"nvim-telescope/telescope.nvim", -- https://github.com/nvim-telescope/telescope.nvim
		},
		config = function()
			local neogit_ok, neogit = pcall(require, "neogit")
			if not neogit_ok then
				vim.notify("[neogit] failed to load.", vim.log.levels.ERROR)
				return
			end
			neogit.setup({ kind = "split" })
		end,
	},

	-- null-ls & mason-null-ls integration
	-- https://github.com/jose-elias-alvarez/null-ls.nvim
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"jayp0521/mason-null-ls.nvim", -- https://github.com/jayp0521/mason-null-ls.nvim
		},
		config = function()
			require("user.plugin_config.null-ls").setup()
		end,
	},

	-- snacks
	-- https://github.com/folke/snacks.nvim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("user.plugin_config.snacks").setup()
		end,
	},

	-- telescope.nvim
	-- https://github.com/nvim-telescope/telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	-- telescope-fzf-native.nvim
	-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},

	-- neotest
	-- https://github.com/nvim-neotest/neotest
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
			"nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
			"antoinemadec/FixCursorHold.nvim", -- https://github.com/antoinemadec/FixCursorHold.nvim
			"haydenmeade/neotest-jest", -- https://github.com/haydenmeade/neotest-jest
			"nvim-neotest/nvim-nio", -- https://github.com/nvim-neotest/nvim-nio
		},
	},

	-- lazygit.nvim
	-- https://github.com/kdheepak/lazygit.nvim
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- mason.nvim
	-- https://github.com/williamboman/mason.nvim
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			local mason_ok, mason = pcall(require, "mason")
			if not mason_ok then
				vim.notify("[mason] failed to load.", vim.log.levels.ERROR)
				return
			end
			mason.setup({
				automatic_installation = true, -- Automatically install missing LSPs
			})
		end,
	},

	-- mason-lspconfig.nvim
	-- https://github.com/williamboman/mason-lspconfig.nvim
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local mlsp_ok, mlsp = pcall(require, "mason-lspconfig")
			if not mlsp_ok then
				vim.notify("[mason-lspconfig] failed to load.", vim.log.levels.ERROR)
				return
			end
			-- this only contains languages that Mason knows about.
			-- languages like gleam are installed separately and aren't included here
			mlsp.setup({
				ensure_installed = {
					"ts_ls",
					"bashls",
					"lua_ls",
					"taplo",
				},
				automatic_installation = true,
			})
		end,
	},

	-- nvim-lspconfig
	-- https://github.com/neovim/nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("user.plugin_config.lspconfig").setup()
		end,
	},

	-- vim-easymotion
	-- https://github.com/easymotion/vim-easymotion
	{
		"easymotion/vim-easymotion",
		init = function()
			-- Disable default mappings
			vim.g.EasyMotion_do_mapping = 0
		end,
	},

	-- nvim-gx
	-- https://github.com/chrishrb/nvim-gx
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
		config = true, -- default settings
		submodules = false, -- not needed, submodules are required only for tests
	},

	-- catppuccin/nvim
	-- https://github.com/catppuccin/nvim
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- copilot.lua
	-- https://github.com/zbirenbaum/copilot.lua
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup()
		end,
	},

	-- copilot-cmp
	-- https://github.com/zbirenbaum/copilot-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- folks.trouble.nvim
	-- https://github.com/folke/trouble.nvim
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		config = function()
			require("user.plugin_config.trouble").setup()
		end,
		keys = function()
			return require("user.plugin_config.trouble").keys
		end,
	},

	-- focus.nvim
	-- https://github.com/nvim-focus/focus.nvim
	{
		"nvim-focus/focus.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("user.plugin_config.focus").setup()
		end,
	},

	-- tabby.nvim
	-- https://github.com/nanozuki/tabby.nvim
	{
		"nanozuki/tabby.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("user.plugin_config.tabby")
		end,
	},
}
