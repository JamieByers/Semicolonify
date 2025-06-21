# Semicolonify.nvim

A simple Neovim plugin that automatically adds semicolons to lines that don't end with one.

## Features

- Adds semicolons to lines that don't already end with specific characters
- Configurable file type support
- Lightweight and fast
- Works around large string e.g. """
- Visual mode ability

## Usage

The plugin will add semicolons to every line that doesn't end with any of these default characters:
- `[` (opening bracket)
- `]` (closing bracket)
- `{` (opening brace)
- `}` (closing brace)
- `;` (semicolon)
- `:` (colon)
- `.` (period)

### Basic Command

```lua
require("semicolonify").semicolonify()
```

## Configuration

The plugin only works on file types you explicitly allow. You can specify custom file types or use the default ones.

File Types:
- Custom file types: Specify an array of file types
- Default file types: Use "*" to include built-in defaults
- Combined: Mix custom file types with defaults using "*"

Other configurations:
- Punctuation: choose to add additional punctuation to avoid adding semicolons to
- Terminator: this changes the terminator from ";"
- Run on save: this runs the plugin when the file is saved 

### Installation Example (Lazy.nvim)

```lua
return {
    "JamieByers/semicolonify.nvim",
    name = "semicolonify",
    lazy = false,
    config = function()
        require("semicolonify").setup({
            filetypes = {"*", "typescript"},
            punctuation = {"*", ")"},
            terminator = ";",
            run_on_save = true,
        })
    end
}
```

## Default Configuration

```lua
local default_config = {
    filetypes = {
        "c",
        "cpp",
        "java",
        "javascript",
        "typescript",
        ...
    },

    punctuation = { "{", "}", ";", ":", "."},
    terminator = ";",
    run_on_save = true
}
```

## Recommended Keymaps

```lua
vim.keymap.set("n", "<leader><leader>;", function()
    require("semicolonify").semicolonify()
end)

vim.keymap.set("n", "<leader>;", function()
    require("semicolonify").semicolonify()
end)

vim.keymap.set("v", "<leader><leader>;", function()
    require("semicolonify").VisualSemicolonify()
end)

vim.keymap.set("v", "<leader>;", function()
    require("semicolonify").VisualSemicolonify()
end)
```

