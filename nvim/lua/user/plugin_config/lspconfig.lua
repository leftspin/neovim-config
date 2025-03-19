local M = {}

function M.setup()
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
  
  -- add swiftinterface as an alias for swift filetype and gleam filetype
  vim.filetype.add({
    extension = {
      swift = "swift",
      swiftinterface = "swift", -- Treat .swiftinterface files as Swift
      gleam = "gleam",     -- Treat .gleam files as Gleam
    },
  })

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

  local servers = { "ts_ls", "sourcekit", "bashls", "lua_ls", "taplo", "gleam" }
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
      })
    elseif server == "lua_ls" then
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              library = vim.api.nvim_list_runtime_paths(),
            },
            telemetry = { enable = false },
          },
        },
      })
    elseif server == "gleam" then
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "gleam", "lsp" }, -- Command to start the Gleam LSP server
        filetypes = { "gleam" },
      })
    else
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
  end
end

return M