# Semicolonify.nvim

A simple Neovim plugin that automatically adds semicolons to lines that don't end with one.

## Features

- Adds semicolons to lines that don't already end with specific characters
- Configurable file type support
- Lightweight and fast

## Usage

The plugin will add semicolons to every line that doesn't end with any of these characters:
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
File Types

- Custom file types: Specify an array of file types
- Default file types: Use "*" to include built-in defaults
- Combined: Mix custom file types with defaults using "*"

### Setup Example (Lazy.nvim)

```lua
return {
    dir = "~/path/to/semicolonify",
    name = "semicolonify",
    lazy = false,
    config = function()
        require("semicolonify").setup({
            filetypes = {"*"}
        })
    end
}
```

## Recommended Keymap

```lua
vim.keymap.set("n", "<leader><leader>;", function()
    require("semicolonify").semicolonify()
end)
```

