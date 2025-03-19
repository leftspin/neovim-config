local M = {}

function M.setup()
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
      { name = "copilot",  group_index = 2 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "luasnip",  group_index = 2 },
      { name = "buffer",   group_index = 3 },
      { name = "path",     group_index = 3 },
    }),
  })
end

return M