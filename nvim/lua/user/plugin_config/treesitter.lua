-------------------------------------------------------
-- lua/user/plugin_config/treesitter.lua
-------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
    "latex" -- for avoiding the latex parser warning
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})