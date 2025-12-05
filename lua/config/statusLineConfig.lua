---@diagnostic disable-next-line: missing-fields
local colors = require("tokyonight.colors").setup({ style = "night" })
local util = require("tokyonight.util")

local function darkend(color)
    return util.darken(color, 0.3)
end

local function getNextActiveSeverityColor(severity)
    local diagnosticColorsMap = {}
    diagnosticColorsMap[vim.diagnostic.severity.ERROR] = colors.error
    diagnosticColorsMap[vim.diagnostic.severity.WARN] = colors.warning
    diagnosticColorsMap[vim.diagnostic.severity.HINT] = colors.hint
    diagnosticColorsMap[vim.diagnostic.severity.INFO] = colors.info

    while severity > 0 do
        if vim.diagnostic.count(0)[severity - 1] ~= nil then
            return util.darken(darkend(diagnosticColorsMap[severity - 1]), 0.5)
        end
        severity = severity - 1
    end

    return colors.dark3
end

-- Generates a component table for the given diagnostic
local function generateDiagnosticComponentTable(severity, color, icon)
    return {
        provider = function()
            local errors = vim.diagnostic.count(0)[severity];
            if errors ~= nil then
                return tostring(errors) .. " "
            else
                return ""
            end
        end,
        hl = function()
            return {
                fg = color,
                bg = darkend(color),
                style = "bold",
            }
        end,
        left_sep = function()
            return
            {
                str = "left_rounded",
                hl = {
                    fg = darkend(color),
                    bg = util.brighten(getNextActiveSeverityColor(severity), 0.7),
                },
            }
        end,
        icon = {
            str = icon .. " ",
            hl = {
                fg = color,
            },
        }
    }
end

function FelineConfig()
    local feline = require("feline")

    local vi_mode_colors = {
        NORMAL = util.lighten(colors.blue2, 0.7),
        OP = colors.orange,
        INSERT = util.lighten(colors.red1, 0.7),
        VISUAL = colors.blue,
        LINES = colors.blue,
        BLOCK = colors.blue,
        REPLACE = colors.orange,
        SELECT = colors.yellow,
        COMMAND = colors.magenta,
    }

    local c = {
        vi_mode = {
            provider = {
                name = "vi_mode",
                opts = { show_mode_name = true },
            },
            hl = function()
                return {
                    fg = util.darken(colors.dark3, 0.12), -- "#222436",
                    bg = require("feline.providers.vi_mode").get_mode_color(),
                    style = "bold",
                    name = "NeovimModeHLColor",
                }
            end,
            left_sep = "block",
            right_sep = function()
                return {
                    str = "█",
                    hl = {
                        fg = require("feline.providers.vi_mode").get_mode_color(),
                        bg = colors.dark3
                    }
                }
            end
        },
        file_path = {
            provider = {
                name = 'file_info',
                opts = {
                    file_modified_icon = '󰝒',
                    file_readonly_icon = '󰈡',
                    type = 'relative'
                }
            },
            short_provider = {
                name = 'file_info',
                opts = {
                    file_modified_icon = '󰝒',
                    file_readonly_icon = '󰈡',
                }
            },
            hl = {
                fg = util.darken("#F2F0EF", 0.8),
                bg = colors.dark3
            },
            left_sep = 'block'
        },
        diagnostic_errors = generateDiagnosticComponentTable(vim.diagnostic.severity.ERROR, colors.error, ""),
        diagnostic_warnings = generateDiagnosticComponentTable(vim.diagnostic.severity.WARN, colors.warning, ""),
        diagnostic_hints = generateDiagnosticComponentTable(vim.diagnostic.severity.HINT, colors.hint, ""),
        diagnostic_info = generateDiagnosticComponentTable(vim.diagnostic.severity.INFO, colors.info, "󰋽"),
    }

    -- TODO search count, for the middle or right
    local active = {
        -- left
        {
            c.vi_mode,
            c.file_path,
            -- TODO Git Things
        },
        -- middle
        {

        },
        -- right
        {
            c.diagnostic_errors,
            c.diagnostic_warnings,
            c.diagnostic_info,
            c.diagnostic_hints,
            --TODO IDEKKKK LOOK AT SOME EXAMPLES. DEFINITELY DIAGNOSTICS WITH THE EXPANDING WINDOWS THING WITH THE SEPERATORS
        }
    }

    -- TODO entire inactive
    local inactive = {
        -- left
        {

        },
        -- middle
        {

        },
        -- right
        {

        }
    }

    feline.setup({
        components = { active = active, inactive = inactive },
        vi_mode_colors = vi_mode_colors,
    })
end

return { FelineConfig = FelineConfig }
