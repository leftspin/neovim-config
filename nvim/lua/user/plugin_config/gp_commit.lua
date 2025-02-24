local M = {}

function M.generate_commit_message()
  -- Capture the output of 'git diff --cached'
  local handle = io.popen("git diff --cached")
  local diff = handle:read("*a")
  handle:close()

  -- Check if there's anything staged for commit
  if diff == "" then
    print("No staged changes to commit.")
    return
  end

  -- Prepare the prompt string
  local prompt = [[You are an AI that writes short, conventional commit messages.
Focus on the staged diff.
1) First line: conventional commit format (feat, fix, etc.)
2) Optionally bullet points if needed.
Return only the final message with no extraneous text.

Staged diff:
]] .. diff

  local gp = require("gp")
  local agent = gp.get_command_agent()

  -- Provide minimal line/range info in the params
  local params = {
    range = 0,  -- indicates no selection range
    line1 = 1,  -- minimal line index
    line2 = 1,  -- minimal line index
  }

  gp.Prompt(params, gp.Target.buffer, agent, prompt)
end

vim.api.nvim_create_user_command("GenerateCommitMessage", function()
  M.generate_commit_message()
end, {})

return M