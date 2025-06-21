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
    },

    punctuation = { "{", "}", ";", ":", "."},
    terminator = ";",
    run_on_save = true
}

local function check_if_comment(line)
   if line:match("^%s*#") then
        return true
    elseif contains(string.sub(line, 1, 2), {"//", "/*", "--"}) then
        return true
    else
        return false
    end
end

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

    if contains("*", M.config.punctuation) then
       for _, punc in ipairs(default_config.punctuation) do
            if not contains(punc, M.config.punctuation) then
                table.insert(M.config.punctuation, punc)
            end
        end
    end

    if M.config.run_on_save then
        vim.api.nvim_create_augroup("SemicolonifyAutoGroup", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "SemicolonifyAutoGroup",
            pattern = "*",
            callback = function()
                local filetype = vim.bo.filetype
                if contains(filetype, M.config.filetypes) then
                    M.semicolonify()
                end
            end,
        })
    end
end

local function colonify(lines)
    local edited_lines = {}
    local in_string = false
    local current_delim = nil
    local deliminators = {'"""', "'''", "`"}

    for _, line in ipairs(lines) do
        if not in_string then
            for _, delim in ipairs(deliminators) do
                if line:find(delim) then
                    in_string = true
                    current_delim = delim
                end
            end
        else
            for _, delim in ipairs(deliminators) do
                if line:find(delim) and current_delim == delim then
                    in_string = false
                    current_delim = nil
                end
            end
        end

        if not in_string then
            local line_end = line:sub(-1)
            if contains(line_end, M.config.punctuation) == false
                and line ~= " "
                and line ~= ""
                and not check_if_comment(line)
            then
               table.insert(edited_lines, line .. M.config.terminator)
            else
                table.insert(edited_lines, line)
            end
        else
            table.insert(edited_lines, line)
        end
    end

    return edited_lines
end

function M.semicolonify()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local edited_lines = colonify(lines)

    local filetype = vim.bo.filetype

    local filetypes = M.config.filetypes
    if contains(filetype, filetypes) == true then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, edited_lines)
    end

    local filename = vim.fn.expand("%:t")
    print("Semicolonified", filename)
end

function M.VisualSemicolonify()
    local current_buffer = 0
    local raw_start = vim.api.nvim_buf_get_mark(current_buffer, "<")
    local raw_end = vim.api.nvim_buf_get_mark(current_buffer, ">")

    local startpos = raw_start[1] - 1
    local endpos = raw_end[1] - 1

    if startpos > endpos then
        local temp = startpos
        startpos = endpos
        endpos = temp
        print("Swapped startpos and endpos")
    end

    local lines = vim.api.nvim_buf_get_lines(current_buffer, startpos, endpos + 1, false)
    local edited_lines = colonify(lines)

    vim.api.nvim_buf_set_lines(current_buffer, startpos, endpos + 1, false, edited_lines)
end


return M
