local M = {}

function M.setup()
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
      null_ls.builtins.diagnostics.luacheck.with({
        extra_args = { "--globals", "vim" },
      }),
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
end

return M