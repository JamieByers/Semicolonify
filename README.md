# Semicolonify

This is a simple Neovim Plugin to add a semicolon to every line without a semicolon at the end, unless they end with the following - { "[", "]", "{", "}", ";", ":", "."}

The command to do this is as follows: require("semicolonify").semicolonify()

The plugin is configured to only work on filetypes you have manually allowed. There are default filetypes that are used if there are not manually entered filetypes, you can also add these default filetypes ontop of your manually inputted filetypes using "*".

Here is an example using lazy -

return {
    dir="~/Documents/Code/Projects/semicolonify",
    name = "semicolonify",
    lazy=false,

    config = function()
       require("semicolonify").setup({
            filetypes = {"lua", "*"}
        })
    end
}

--- Recommendation ---

Its much easier to use this plugin if a keymap is set to run semicolonify.

Here is an example setup -

vim.keymap.set("n", "<leader><leader>;", function()
    require("semicolonify").semicolonify()
end)



