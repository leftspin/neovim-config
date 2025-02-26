local M = {}

function M.setup(bufnr)
  local function bufmap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

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

return M
