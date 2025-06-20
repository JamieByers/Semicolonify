local M = {}

local function contains(target, contain)
    for _, c in ipairs(contain) do
        if target == c then
            return true
        end
    end

    return false
end

local default_config = {
    filetypes = {
        "c",
        "cpp",
        "java",
        "javascript",
        "typescript",
        "cs",
        "objc",
        "swift",
        "rust",
        "go",
        "kotlin",
        "scala",
        "php",
        "perl",
        "d",
        "vala",
        "dart",
        "haxe",
        "zig",
        "processing",
        "groovy",
        "fsharp",
        "julia",
        "vhdl",
        "verilog",
        "pascal",
        "asm",
        "nim",
        "ada",
        "fortran",
        "ocaml",
        "coq",
        "elixir",
        "crystal",
        "pony",
        "racket",
        "scheme",
        "bash",
        "fish",
        "zsh",
    }

}

M.config = {}

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
    if contains("*", M.config.filetypes) then
       for _, default_filetype in ipairs(default_config.filetypes) do
            if not contains(default_filetype, M.config.filetypes) then
                table.insert(M.config.filetypes, default_filetype)
            end
        end
    end
end

function M.semicolonify()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local edited_lines = {}

    for _, line in ipairs(lines) do
        local line_end = line:sub(-1)
        if contains(line_end, { "[", "]", "{", "}", ";", ":", "."}) == false and line ~= " " and line ~= "" then
           table.insert(edited_lines, line .. ";")
        else
            table.insert(edited_lines, line)
        end
    end

    local filetype = vim.bo.filetype

    print("Filetype: ", filetype)

    local filetypes = M.config.filetypes
    if contains(filetype, filetypes) == true then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, edited_lines)
    end
end


return M
