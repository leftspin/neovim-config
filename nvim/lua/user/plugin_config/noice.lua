local M = {}

function M.setup()
  local opts = {
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
        search_down = { kind = "search", icon = " " },
        search_up = { kind = "search", icon = " " },
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
  }

  local noice_ok, noice_mod = pcall(require, "noice")
  if not noice_ok then
    vim.notify("[noice] failed to load in config function.", vim.log.levels.ERROR)
    return
  end
  noice_mod.setup(opts)

  -- Style signature help
  vim.api.nvim_set_hl(0, "NoiceLspSignature", { bg = "#ff0000", fg = "#ffffff" })
end

return M