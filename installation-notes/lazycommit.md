# This file needs to be placed in: `~/Library/Application Support/lazygit/config.yml`

```yml
customCommands:
  - key: "<c-a>" # Ctrl + A
    description: "Generate AI Commit Message"
    command: 'echo "{{.Form.Msg}}" > .git/COMMIT_EDITMSG && nvim .git/COMMIT_EDITMSG && [ -s .git/COMMIT_EDITMSG ] && git commit -F .git/COMMIT_EDITMSG || echo "Commit message is empty, commit aborted."'
    context: "files"
    subprocess: true
    prompts:
      - type: "menuFromCommand"
        title: "AI Commit Messages"
        key: "Msg"
        command: 'npx @m7medvision/lazycommit@latest'
        filter: '^(?P<number>\d+)\.\s(?P<message>.+)$'
        valueFormat: "{{ .message }}"
        labelFormat: "{{ .number }}: {{ .message | green }}"
```

# You need to configure lazy git's API tokens using its configurator. Putting it in an env doesn't work.

```bash
# Using Bun
bunx @m7medvision/lazycommit@latest config

# Using npm
npx @m7medvision/lazycommit@latest config
```
