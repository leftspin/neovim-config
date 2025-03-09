local focusmap = function(direction)
	vim.keymap.set("n", "<space><space>" .. direction, function()
		require("focus").split_command(direction)
	end, { desc = string.format("Create or move to split (%s)", direction) })
end

-- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
focusmap("h")
focusmap("j")
focusmap("k")
focusmap("l")

vim.keymap.set("n", "<space><space><space>", "<cmd>FocusMaxOrEqual<CR>", { noremap = true, silent = true })
