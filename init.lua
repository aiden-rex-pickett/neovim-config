-- AIDEN PICKETT WINDOWS 11 NEOVIM CONFIG FILE --

-- Globals for editor control --
DEFAULT_COLORSCHEME = "tokyonight"
vim.cmd("set termguicolors")
vim.cmd("set noshowmode")

-- Shell things --
vim.opt.shell = "cmd.exe"

local errorMap = {}
function RequireWithErrorCheck(path)
    local sucess, err = pcall(require, path)
    if not sucess then
        errorMap[path] = err
    end
end

-- Plugin manger things --
RequireWithErrorCheck("config.lazy")

-- Neovide (if present) --
if vim.g.neovide then
    RequireWithErrorCheck("config.neovide_config")
end

-- Keymaps --
RequireWithErrorCheck("core.keymaps")

-- Line number and tab settings --
RequireWithErrorCheck("core.lines_and_tabs")

-- Custom commands --
RequireWithErrorCheck("core.custom_commands")

-- Set Colorscheme --
RequireWithErrorCheck("config.colorscheme_config")
vim.cmd("colorscheme " .. DEFAULT_COLORSCHEME)

-- Autocomplete --
RequireWithErrorCheck("config.nvim_cmp_config")

-- Lsp Configuration --
RequireWithErrorCheck("config.lsp_config")

function PrintErrorMessages()
    print([[

 ██████  ███████  ██   ██  ███████  ██████   ██████       ███████  ██████   ██████   ███████  ██████
██       ██   ██  ███  ██  ██         ██    ██            ██       ██   ██  ██   ██  ██   ██  ██   ██
██       ██   ██  ██ █ ██  ███████    ██    ██  ███       ███████  ██████   ██████   ██   ██  ██████
██       ██   ██  ██  ███  ██         ██    ██    ██      ██       ██   ██  ██   ██  ██   ██  ██   ██
 ██████  ███████  ██   ██  ██       ██████   ██████       ███████  ██   ██  ██   ██  ███████  ██   ██
    ]])
    local errorCount = 0
    for _, _ in pairs(errorMap) do errorCount = errorCount + 1 end
    print("There were " .. errorCount .. " error(s) when loading the init.lua config file")
    for path, err in pairs(errorMap) do
        print("----------------------------------------------------------------------------------------------------")
        print("error when attempting to load " .. path .. " module:\n\n")
        print(err)
    end
end

if next(errorMap) ~= nil then
    PrintErrorMessages()
end
