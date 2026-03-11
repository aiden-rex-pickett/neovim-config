-- Configuration for the "tokyonight" colorscheme --
local util = require("tokyonight.util")
require("tokyonight").setup(
    {
        styles = {
            --[[
            Styles for each syntax group, see the :help nvim_set_hl
            values list for a list of valid table properties
        --]]
            comments = { italic = true },
            keywords = { italic = false, bold = true },
        },
        on_highlights = function(hl, colors)
            hl.Search = { fg = colors.blue1, bg = util.darken(colors.red1, 0.8) }
            hl.IncSearch = { fg = '#222436', bg = util.lighten(colors.red1, 0.8) }
            hl.Visual = { bg = util.darken(colors.cyan, 0.2) }
            hl.Yank = { bg = util.darken(colors.cyan, 0.3), fg = util.lighten(colors.red, 1.5) }
        end,
    })

local colors = require("tokyonight.colors").setup({ style = "night" })

-- Testing custom captures --

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- Custom capture group for only the name of functions in function definitions --
        vim.api.nvim_set_hl(0, "@lsp.type.function.lua", {})

        local functionColor = { fg = util.lighten(colors.blue2, 0.9), bold = true }
        vim.api.nvim_set_hl(0, "@function.lua", functionColor)

        -- Custom capture group for only the name of parameters in the function --
        vim.api.nvim_set_hl(0, "@lsp.type.parameter.lua", {})

        local parametersColor = { fg = util.lighten(colors.red1, 0.85), italic = true, force = true }
        vim.api.nvim_set_hl(0, "@variable.parameter.lua", parametersColor)
    end
})
