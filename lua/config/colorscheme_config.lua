-- Configuration for the "tokyonight" colorscheme --
require("tokyonight").setup(
    {
        styles = {
            --[[
            Styles for each syntax group, see the :help nvim_set_hl
            values list for a list of valid table properties
        --]]
            comments = { italic = true },
            keywords = { italic = false },
        },
        on_highlights = function(hl, colors)
            hl.Search = { bg = colors.orange, fg = "black" }
            hl.Visual = { bg = colors.blue }
        end,
    })

local colors = require("tokyonight.colors").setup({ style = "night" })
local util = require("tokyonight.util")

-- Testing custom captures for lua --

-- Custom capture group for only the name of functions in function definitions --
local functionColor = { fg = util.lighten(colors.blue2, 0.9), bold = true }
vim.api.nvim_set_hl(0, "@function.definition.name", functionColor)

-- Custom capture group for only the name of parameters in the function --
local parametersColor = { fg = util.lighten(colors.red1, 0.85), italic = true }
vim.api.nvim_set_hl(0, "@function.definition.parameters.name", parametersColor)
