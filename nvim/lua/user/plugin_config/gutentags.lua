-------------------------------------------------------
-- lua/user/plugin_config/gutentags.lua
-------------------------------------------------------
local g = vim.g

g.gutentags_cache_dir = vim.fn.expand("~/.cache/vim/ctags/")
g.gutentags_add_default_project_roots = 0
g.gutentags_project_root = { "package.json", ".git" }
g.gutentags_exclude_filetypes = { "gitcommit", "gitconfig", "gitrebase", "gitsendemail", "git" }
g.gutentags_generate_on_new = 1
g.gutentags_generate_on_missing = 1
g.gutentags_generate_on_write = 1
g.gutentags_generate_on_empty_buffer = 0
g.gutentags_ctags_extra_args = { "--tag-relative=yes", "--fields=+ailmnS" }
g.gutentags_ctags_exclude = {
  "*.git", "*.svn", "*.hg",
  "cache", "build", "dist", "bin", "node_modules", "bower_components",
  "*.d.ts*",
  "*-lock.json", "*.lock",
  "*.min.*",
  "*.bak",
  "*.zip",
  "*.pyc",
  "*.class",
  "*.sln",
  "*.csproj", "*.csproj.user",
  "*.tmp",
  "*.cache",
  "*.vscode",
  "*.pdb",
  "*.exe", "*.dll", "*.bin",
  "*.mp3", "*.ogg", "*.flac",
  "*.swp", "*.swo",
  ".DS_Store", "*.plist",
  "*.bmp", "*.gif", "*.ico", "*.jpg", "*.png", "*.svg",
  "*.rar", "*.zip", "*.tar", "*.tar.gz", "*.tar.xz", "*.tar.bz2",
  "*.pdf", "*.doc", "*.docx", "*.ppt", "*.pptx", "*.xls",
}
