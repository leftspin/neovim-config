-------------------------------------------------------
-- lua/user/keymaps.lua
-------------------------------------------------------
local keymap = vim.keymap.set
local opts   = { silent = true }

--------------------------
-- TELESCOPE
--------------------------
-- <space>o => find_files
-- keymap("n", "<space>o", function()
--   require("telescope.builtin").find_files()
-- end, opts)

-- <space>B => buffers
-- keymap("n", "<space>B", function()
--   require("telescope.builtin").buffers()
-- end, opts)

-- <space>g => live_grep
-- keymap("n", "<space>g", function()
--   require("telescope.builtin").live_grep()
-- end, opts)

-- "Conflicts" => search for '<<<<<<'
-- old config had "command! Conflicts Ag<<<<<<"
-- We'll replace with a Telescope-based search
vim.api.nvim_create_user_command("Conflicts", function()
  require("telescope.builtin").grep_string({ search = "<<<<<<" })
end, {})

-- Buffer navigation
keymap("n", "<space>b", ":bn<CR>", opts)

-- Utility
keymap("n", "<space>w", ":up<bar>bp<bar>sp<bar>bn<bar>bd<CR>", opts)
keymap("n", "<space>n", ":noh<CR>", opts)

-- Copilot
keymap("i", "<C-l>", "copilot#Accept('')", { silent = true, script = true, expr = true })
keymap("i", "<C-j>", "<Plug>(copilot-next)", {})
keymap("i", "<C-k>", "<Plug>(copilot-previous)", {})
keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", {})

-- CamelCaseMotion
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

keymap("n", "<space>vs", ":vert sp<CR><C-w>l", opts)
keymap("n", "<space>sp", ":sp<CR><C-w>j", opts)

keymap("n", "<space>gd", ":vert sp | wincmd l | execute \"normal! gd\"<CR>", opts)

-- Avante
keymap("n", ";c", ":AvanteChat<CR>", opts)
keymap("n", ";t", ":AvanteToggle<CR>", opts)
