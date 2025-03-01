-------------------------------------------------------
-- lua/plugins/init.lua
-------------------------------------------------------

-- Diagnostic signs (the old-school diagnostics config, in case there's old apps that use this)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
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
			local cmp_ok, cmp = pcall(require, "cmp")
			if not cmp_ok then
				vim.notify("[nvim-cmp] failed to load.", vim.log.levels.ERROR)
				return
			end

			local luasnip_ok, luasnip = pcall(require, "luasnip")
			if not luasnip_ok then
				vim.notify("[LuaSnip] failed to load.", vim.log.levels.ERROR)
				return
			end

			local vscode_loader_ok, vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
			if vscode_loader_ok then
				vscode_loader.lazy_load()
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					-- Hide docs to avoid conflict with noice signature help
					documentation = cmp.config.disable,
				},
				-- Mappings for nvim-cmp are now defined in lua/user/keymaps.lua
				mapping = require("user.keymaps").get_cmp_mappings(),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
					{ name = "buffer", group_index = 3 },
					{ name = "path", group_index = 3 },
				}),
			})
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
			-- Define colors from clarity theme
			local colors = {
				bg = "#2a4565", -- Main background
				bg_dark = "#102030", -- StatusLine background
				bg_light = "#304E73", -- CursorLine background
				fg = "#a5e9ff", -- Normal foreground
				fg_dark = "#4382CB", -- LineNr foreground
				blue = "#5fa1db", -- Statement
				green = "#70d080", -- Identifier
				yellow = "#ecad2b", -- Constant/Number
				orange = "#fb5baa", -- String
				purple = "#8f9ae5", -- Comment
				cyan = "#8cd0d3", -- Type
				red = "#FF6347", -- DiagnosticError
				gray = "#8090a0", -- Delimiter
			}

			-- Setup lualine with custom theme
			require("lualine").setup({
				options = {
					theme = {
						normal = {
							a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
							b = { bg = "#332b15", fg = colors.yellow }, -- Dark orange tint for path section
							c = { bg = colors.bg, fg = colors.fg },
							x = { bg = colors.bg, fg = colors.fg },
							y = { bg = "#1a2e1a", fg = colors.green }, -- Dark green tint for progress
							z = { bg = "#1a2a33", fg = colors.cyan }, -- Dark cyan tint for location
						},
						insert = {
							a = { bg = colors.green, fg = colors.bg, gui = "bold" },
							b = { bg = "#332b15", fg = colors.yellow },
							y = { bg = "#1a2e1a", fg = colors.green },
							z = { bg = "#1a2a33", fg = colors.cyan },
						},
						visual = {
							a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
							b = { bg = "#332b15", fg = colors.yellow },
							y = { bg = "#1a2e1a", fg = colors.green },
							z = { bg = "#1a2a33", fg = colors.cyan },
						},
						replace = {
							a = { bg = colors.red, fg = colors.bg, gui = "bold" },
							b = { bg = "#332b15", fg = colors.yellow },
							y = { bg = "#1a2e1a", fg = colors.green },
							z = { bg = "#1a2a33", fg = colors.cyan },
						},
						command = {
							a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
							b = { bg = "#332b15", fg = colors.yellow },
							y = { bg = "#1a2e1a", fg = colors.green },
							z = { bg = "#1a2a33", fg = colors.cyan },
						},
						inactive = {
							a = { bg = colors.bg, fg = colors.fg_dark, gui = "bold" },
							b = { bg = colors.bg, fg = colors.fg_dark }, -- Subdued color for inactive path
							c = { bg = colors.bg, fg = colors.fg_dark },
							x = { bg = colors.bg, fg = colors.fg_dark },
							y = { bg = colors.bg, fg = colors.fg_dark },
							z = { bg = colors.bg, fg = colors.fg_dark },
						},
					},
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						-- Custom function to show CWD + path + filename with modified/readonly indicators
						{
							function()
								local cwd = vim.fn.getcwd()
								local path = vim.fn.expand("%:p")
								-- Extract relative path from the current working directory
								local rel_path = path:gsub(vim.fn.getcwd() .. "/", "")

								-- Add modified/readonly indicators
								local modified = ""
								if vim.bo.modified then
									modified = "  "
								end
								local readonly = ""
								if vim.bo.readonly then
									readonly = "  "
								end

								return cwd .. " ▶ " .. rel_path .. modified .. readonly
							end,
							color = { fg = colors.yellow },
							padding = { left = 1, right = 1 },
						},
					},
					lualine_c = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
							diagnostics_color = {
								error = { fg = colors.red },
								warn = { fg = colors.yellow },
								info = { fg = colors.blue },
								hint = { fg = colors.cyan },
							},
						},
					},
					lualine_x = {
						{ "encoding" },
						{
							"fileformat",
							icons_enabled = true,
						},
						{ "filetype", icon_only = false, padding = { left = 1, right = 1 } },
					},
					lualine_y = {
						{
							"progress",
							icon = "     ",
							padding = { left = 1, right = 1 },
							color = { fg = colors.green },
						},
					},
					lualine_z = {
						{ "location", icon = "󰍎", padding = { left = 1, right = 1 }, color = { fg = colors.cyan } },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {
						-- Show path in inactive buffers too
						{
							function()
								local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
								local path = vim.fn.expand("%:p")
								-- Extract relative path from the current working directory
								local rel_path = path:gsub(vim.fn.getcwd() .. "/", "")
								return cwd .. " ▶ " .. rel_path
							end,
						},
					},
					lualine_c = {},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
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
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
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
	-- https://github.com/folke/noice.nvim
	{
		"folke/noice.nvim",
		version = "*", -- fetch the latest stable version
		lazy = false, -- load early, no lazy/event
		opts = {
			-- Show signature help upon typing (the normal behavior)
			lsp = {
				signature = {
					enabled = false,
					-- auto_open = { trigger = true },
				},
			},
			-- Show :messages in a noice-style split for easy copying
			messages = {
				enabled = true,
			},
			routes = {
				-- route #2: confirm prompt in a popup
				{
					filter = {
						event = "msg_show",
						kind = "confirm",
					},
					view = "confirm",
				},
			},
			-- Use a popup cmdline and confirm for unsaved-changes prompt
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { icon = "➜" }, -- Restored the ">" character
					search_down = { kind = "search", icon = " " },
					search_up = { kind = "search", icon = " " },
				},
			},
			popupmenu = {
				enabled = true, -- keep popup menu for cmdline
			},

			-- Show a confirm popup for unsaved changes
			views = {
				cmdline_popup = {
					position = {
						row = "30%",
					},
				},
				confirm = {
					backend = "popup",
					relative = "editor",
					border = {
						style = "rounded",
					},
				},
			},
		},
		config = function(_, opts)
			local noice_ok, noice_mod = pcall(require, "noice")
			if not noice_ok then
				vim.notify("[noice] failed to load in config function.", vim.log.levels.ERROR)
				return
			end
			noice_mod.setup(opts)

			-- Style signature help
			vim.api.nvim_set_hl(0, "NoiceLspSignature", { bg = "#ff0000", fg = "#ffffff" })
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

	-- vim-commentary
	-- https://github.com/tpope/vim-commentary
	{ "tpope/vim-commentary" },

	-- vim-rhubarb
	-- https://github.com/tpope/vim-rhubarb
	{ "tpope/vim-rhubarb" },

	-- vim-dispatch
	-- https://github.com/tpope/vim-dispatch
	{ "tpope/vim-dispatch" },

	-- CamelCaseMotion
	-- https://github.com/bkad/CamelCaseMotion
	{ "bkad/CamelCaseMotion" },

	-- vim-sneak
	-- https://github.com/justinmk/vim-sneak
	{ "justinmk/vim-sneak" },

	-- emmet-vim
	-- https://github.com/mattn/emmet-vim
	{ "mattn/emmet-vim" },

	-- Removed lightline-onedark (not needed with built-in statusline)
	-- -- https://github.com/hallzy/lightline-onedark
	-- { "hallzy/lightline-onedark" },

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
		opts = {
			ensure_installed = "all",
			highlight = { enable = true },
			playground = {
				enable = true,
				disable = {},
				updatetime = 25,
				persist_queries = false,
				-- Keybindings for treesitter playground are now defined in lua/user/keymaps.lua
				keybindings = require("user.keymaps").treesitter_playground_keybindings,
			},
		},
		config = function(_, opts)
			local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
			if not ts_ok then
				vim.notify("[nvim-treesitter] failed to load configs.", vim.log.levels.ERROR)
				return
			end
			ts_configs.setup(opts)
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
			local mason_null_ok, mason_null_ls = pcall(require, "mason-null-ls")
			local null_ls_ok, null_ls = pcall(require, "null-ls")

			if not mason_null_ok then
				vim.notify("[mason-null-ls] failed to load.", vim.log.levels.ERROR)
				return
			end
			if not null_ls_ok then
				vim.notify("[null-ls] failed to load.", vim.log.levels.ERROR)
				return
			end

			mason_null_ls.setup({
				ensure_installed = {
					"eslint_d",
					"prettierd",
					"swiftlint",
					"swiftformat",
					"shellcheck",
					"shfmt",
					"stylua",
					"luacheck",
				},
				automatic_installation = true,
			})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.formatting.swiftformat,
					null_ls.builtins.diagnostics.swiftlint,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.luacheck,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local formatting_group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
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
	-- https://github.com/folke/snacks.nvim
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false }, -- Disabled to use built-in statusline
			toggle = {
				which_key = true,
				notify = true,
			},
			words = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					-- { section = "keys", gap = 1, padding = 1 },
					{
						pane = 1,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						padding = 1,
					},
					{
						icon = " ",
						title = "Projects",
						section = "projects",
						padding = 1,
					},
					{ section = "startup" },
				},
			},
		},
		-- Keybindings for snacks.nvim are now defined in lua/user/keymaps.lua
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
			mason.setup()
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
			mlsp.setup({
				ensure_installed = {
					"ts_ls",
					"bashls",
					"lua_ls",
				},
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
			local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
			if not lspconfig_ok then
				vim.notify("[nvim-lspconfig] failed to load.", vim.log.levels.ERROR)
				return
			end

			local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not cmp_lsp_ok then
				vim.notify("[cmp_nvim_lsp] not found, LSP completions may be limited.", vim.log.levels.WARN)
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if cmp_lsp_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
				capabilities.textDocument.completion.completionItem.snippetSupport = true
			end

			local on_attach = function(client, bufnr)
				-- Apply buffer-local LSP keymaps
				local user_keymaps_ok, user_keymaps = pcall(require, "user.keymaps")
				if user_keymaps_ok then
					user_keymaps.setup_lsp_keymaps(bufnr)
				end

				-- Attach signature plugin
				local lsp_sig_ok, lsp_signature = pcall(require, "lsp_signature")
				if lsp_sig_ok then
					lsp_signature.on_attach({
						bind = true,
						handler_opts = {
							border = "rounded",
						},
						floating_window = true,
						hint_enable = true,
						hint_prefix = " ",
					}, bufnr)
				end
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
				elseif server == "lua_ls" then
					lspconfig[server].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME")] = true,
									},
								},
								telemetry = { enable = false },
							},
						},
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
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
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
		opts = {}, -- for default options, refer to the configuration section for custom setup.
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
}
