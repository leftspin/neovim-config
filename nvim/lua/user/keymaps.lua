-------------------------------------------------------
-- lua/user/keymaps.lua
-------------------------------------------------------
local keymap = vim.keymap.set
local opts = { silent = true }

--------------------------
-- LSP KEYMAPS
--------------------------
local M = {}

-- Buffer-local LSP keymaps setup function
function M.setup_lsp_keymaps(bufnr)
  local function bufmap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Show hover documentation
  bufmap("n", "K", vim.lsp.buf.hover, "Show Hover Documentation")

  -- LSP buffer-local mappings
  bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  bufmap("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  bufmap("n", "gr", vim.lsp.buf.references, "Go to References")
  bufmap("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  bufmap("n", "<leader>e", vim.diagnostic.open_float, "Show Line Diagnostics")
  bufmap("n", "<space>k", vim.diagnostic.goto_prev, "Prev Diagnostic")
  bufmap("n", "<space>j", vim.diagnostic.goto_next, "Next Diagnostic")
  bufmap("n", "<C-i>", function()
    vim.lsp.buf.format()
  end, "Format All")
end

--------------------------
-- GITSIGNS
--------------------------
-- Implemented in on_attach function in plugins/init.lua
-- This is a reference for the key binding
keymap("n", "<leader>gb", function()
  local gs_ok, gs = pcall(require, "gitsigns")
  if not gs_ok then
    vim.notify("[gitsigns] failed to load.", vim.log.levels.ERROR)
    return
  end
  gs.toggle_current_line_blame()
end, { desc = "Toggle Git Line Blame" })

--------------------------
-- WHICH-KEY
--------------------------
keymap("n", "<space>?", function()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("[which-key] failed to load.", vim.log.levels.ERROR)
    return
  end
  wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

--------------------------
-- NVIM-CMP KEYMAPS
--------------------------
-- These keymaps will be used in the nvim-cmp setup function
-- They need to be integrated into the cmp.setup() call in the plugin config

-- Snacks.nvim configuration will use these key mappings
local function setup_nvim_cmp_mappings()
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok then
    vim.notify("[nvim-cmp] failed to load.", vim.log.levels.ERROR)
    return {}
  end

  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    vim.notify("[LuaSnip] failed to load.", vim.log.levels.ERROR)
    return {}
  end

  return cmp.mapping.preset.insert({
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
  })
end

-- Add function to the module
M.get_cmp_mappings = setup_nvim_cmp_mappings

-- Export function for LSP keybindings (already defined at the top)
-- M.setup_lsp_keymaps is already defined, don't reassign

--------------------------
-- NEOTEST
--------------------------
keymap("n", "<space>t", function()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    vim.notify("[neotest] failed to load.", vim.log.levels.ERROR)
    return
  end
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run tests in current file" })

keymap("n", "<space>T", function()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    vim.notify("[neotest] failed to load.", vim.log.levels.ERROR)
    return
  end
  neotest.run.run()
end, { desc = "Run nearest test" })

keymap("n", "<space>ts", function()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    vim.notify("[neotest] failed to load.", vim.log.levels.ERROR)
    return
  end
  neotest.run.stop()
end, { desc = "Stop nearest test" })

keymap("n", "<space>to", function()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    vim.notify("[neotest] failed to load.", vim.log.levels.ERROR)
    return
  end
  neotest.output.open({ enter = true })
end, { desc = "Open test output" })

--------------------------
-- UTILITY
--------------------------

-- Fill line with underscores
keymap("n", "<space>-", function()
  FillLine("_")
end, { silent = true, desc = "Fill line with underscores" })

--------------------------
-- SNACKS.NVIM
--------------------------
keymap("n", "<leader>\\", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open terminal.", vim.log.levels.ERROR)
    return
  end
  Snacks.terminal()
end, { desc = "Toggle Terminal" })

keymap("n", "<space>o", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open smart picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })

keymap("n", "<space>B", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open buffers picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.buffers()
end, { desc = "Buffers" })

keymap("n", "<space>g", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open grep picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.grep()
end, { desc = "Grep" })

keymap("n", "<space>`", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot show notifications.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.notifications()
end, { desc = "Notification History" })

keymap("n", "<space>e", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open explorer.", vim.log.levels.ERROR)
    return
  end
  Snacks.explorer()
end, { desc = "File Explorer" })

keymap("n", "<space>,", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open config file picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

keymap("n", "<space>r", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open recent files picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.recent()
end, { desc = "Recent" })

keymap("n", "<space>l", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open lines picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.lines()
end, { desc = "Buffer Lines" })

keymap("n", "<space>h", function()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("[snacks] missing, cannot open highlights picker.", vim.log.levels.ERROR)
    return
  end
  Snacks.picker.highlights()
end, { desc = "Highlights" })

--------------------------
-- TREESITTER PLAYGROUND
--------------------------
-- These will be used in the plugin configuration
-- Define the keybindings that will be passed to the setup function
M.treesitter_playground_keybindings = {
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
}

--------------------------
-- TELESCOPE
--------------------------
-- "Conflicts" => search for '<<<<<<'
vim.api.nvim_create_user_command("Conflicts", function()
  require("telescope.builtin").grep_string({ search = "<<<<<<" })
end, {})

--------------------------
-- BUFFER NAVIGATION
--------------------------
keymap("n", "<space>b", ":bn<CR>", opts)

--------------------------
-- EASYMOTION
--------------------------
-- <space>f => word mode
keymap("n", "<space>f", "<Plug>(easymotion-w)", opts)
keymap("n", "<space>F", "<Plug>(easymotion-b)", opts)

--------------------------
-- UTILITY
--------------------------
keymap("n", "<space>n", ":noh<CR>", opts)

--------------------------
-- COPILOT (using copilot-cmp now)
--------------------------
-- Copilot keybindings removed as we're now using copilot-cmp
-- which integrates with the nvim-cmp interface

--------------------------
-- CAMELCASEMOTION
--------------------------
keymap("n", ",w", "<Plug>CamelCaseMotion_w", opts)
keymap("n", ",b", "<Plug>CamelCaseMotion_b", opts)
keymap("n", ",e", "<Plug>CamelCaseMotion_e", opts)
keymap("n", ",ge", "<Plug>CamelCaseMotion_ge", opts)

--------------------------
-- TAB MANAGEMENT
--------------------------
keymap("n", "Tt", ":tabnew<CR>", opts)
keymap("n", "Tj", ":tabnext<CR>", opts)
keymap("n", "Tk", ":tabprev<CR>", opts)
keymap("n", "Tw", ":tabclose<CR>", opts)
keymap("n", "TT", ":tabn ", { silent = false })

--------------------------
-- WINDOW MANAGEMENT
--------------------------
keymap("n", "<space>vs", ":vert sp<CR><C-w>l", opts)
keymap("n", "<space>sp", ":sp<CR><C-w>j", opts)
keymap("n", "<space>gd", ':vert sp | wincmd l | execute "normal! gd"<CR>', opts)

--------------------------
-- AVANTE
--------------------------
keymap("n", ";c", ":AvanteChat<CR>", opts)
keymap("n", ";t", ":AvanteToggle<CR>", opts)
keymap("n", ";f", ":AvanteFocus<CR>", opts)

return M
