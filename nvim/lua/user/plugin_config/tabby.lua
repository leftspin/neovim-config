-- Define highlight groups for different parts of the tabline
-- These reference Vim's built-in highlight groups
local theme = {
  fill = "TabLineFill",        -- Background color for empty space in tabline
  head = "TabLine",            -- Style for the beginning of the tabline
  current_tab = "TabLineSel",  -- Style for the currently selected tab
  tab = "TabWinInactive",      -- Style for non-selected tabs
  win = "TabWinInactive",      -- Style for windows within tabs
  current_win = "TabWinActive", -- Style for the current window (same as current tab)
  tail = "TabLine",            -- Style for the end of the tabline
}

-- Define slant characters using Unicode escape sequences (both bottom-left to upper-right)
-- These are special characters that create the angled separators between tabs
local left_slant = "\u{e0ba}"  -- Powerline left slant character (upper-left filled)
local right_slant = "\u{e0bc}" -- Powerline right slant character (bottom-right filled)

-- Function to extract just the filename from a full buffer path
local function get_filename(buf)
  -- Use Vim's fnamemodify function with :t flag to get just the tail (filename)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
  -- If the buffer has no name, show "" instead
  if filename == "" then
    return ""
  end
  return filename
end

-- Import the tabby.tabline module to create our custom tabline
local tabline = require("tabby.tabline")
-- Get the highlight colors for non-current windows to use for background
local normal_nc_hl = vim.api.nvim_get_hl_by_name("NormalNC", true)
-- Convert the background color to hex format, or nil if not available
local normal_nc_bg = normal_nc_hl.background and string.format("#%06x", normal_nc_hl.background) or nil

-- Set up the tabline with a custom function that returns the tabline structure
tabline.set(function(line)
  return {
    -- Start of tabline with some padding
    {
      { "  ", hl = theme.head }, -- Two spaces with head highlight
    },
    -- Process each tab in the tabline
    line.tabs().foreach(function(tab)
      -- Set highlight based on whether this is the current tab
      local hl = tab.is_current() and theme.current_tab or theme.tab

      -- Get the tab number (handling both function and direct value cases)
      local tab_num = type(tab.number) == "function" and tab.number() or tab.tabnr
      local tab_number = tostring(tab_num) .. " " -- Convert to string and add space

      -- Set up highlight for the slant character based on tab state
      local slant_hl
      if tab.is_current() then
        -- For current tab, use the same highlight as the tab
        slant_hl = hl
      else
        slant_hl = hl
      end

      -- Create the left part of the tab with right slant and tab number
      local tab_section = {
        { right_slant,                 hl = slant_hl }, -- Right slant character with custom highlight
        { " \u{F04E9} " .. tab_number, hl = hl }, -- Space and tab number with tab highlight
      }

      -- Create a list of windows for this tab
      local wins = {}
      for _, win in ipairs(tab.wins().wins) do
        -- Set highlight based on whether this is the current window in current tab
        local win_hl = (win.is_current() and tab.is_current()) and theme.current_win or theme.win
        -- Add window entry to the list with appropriate icon and filename
        table.insert(wins, {
          win.is_current() and "  " or " \u{EB7F} ", -- Different icon for current vs non-current window
          get_filename(win.buf().id), -- Get just the filename for this window
          " ", -- Add space after filename
          hl = win_hl, -- Apply the window highlight
        })
      end

      -- Create the right part of the tab with left slant
      local tab_end = {
        { " ",        hl = hl },   -- Space with tab highlight
        { left_slant, hl = slant_hl }, -- Left slant character with custom highlight
      }

      -- Return the complete tab structure
      return {
        tab_section, -- Left part with tab number
        wins,    -- Middle part with windows
        tab_end, -- Right part with closing slant
      }
    end),
    -- End of tabline with some padding
    { { "  ", hl = theme.tail } }, -- Two spaces with tail highlight
    -- Set the highlight for any remaining space in the tabline
    hl = theme.fill,
  }
end)

-- Configure Vim to always show the tabline
vim.o.showtabline = 2 -- Always show the tab bar (2=always, 1=if multiple tabs, 0=never)

-- Return an empty table (common pattern in Lua modules)
return {}
