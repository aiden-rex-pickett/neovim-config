--- Configures the statusline using Feline.nvim.

--- Alias for the integer representing severity
--- @alias vim.diagnostic.severity integer

---@diagnostic disable-next-line: missing-fields
local colors = require('tokyonight.colors').setup({ style = 'night' })
local util = require('tokyonight.util')

STATUS_LINE_BACKGROUND = colors.dark3
TERMINAL_BACKGROUND = '#222436'
STATUS_LINE_BACKGROUND_DARK = util.darken(TERMINAL_BACKGROUND, 0.6)
STATUS_LINE_TEXT = util.darken('#F2F0EF', 0.8)

--- Darkens a color, for use by the background of the diagnostics
--- @param color string The string representing the color to darken
--- @return string darkendColor the darkened version of the passed color
local function darkened(color)
    return util.darken(color, 0.3)
end

--- Gets next active severity value
--- @param severity vim.diagnostic.severity The severity to base the search on
--- @return vim.diagnostic.severity nextSeverity the next active severity value
local function getNextActiveSeverity(severity)
    -- If the count of the diagnostic one less than this one (1 = ERROR, 4 = HINT) is present on the current buffer, return that color darkened
    while severity > 0 do
        if vim.diagnostic.count(0)[severity - 1] ~= nil then
            return severity - 1
        end
        severity = severity - 1
    end

    return -1 -- For no next severity
end

--- Gets the next active severity color, so that the highlight can be correct across the seperators between diagnostic components
--- @param severity vim.diagnostic.severity The severity of the current component
--- @return string Color The color of the next more severe severity that is active in the current buffer (count > 0)
local function getNextActiveSeverityColor(severity)
    -- Map of severities to colors
    local diagnosticColorsMap = {}
    diagnosticColorsMap[vim.diagnostic.severity.ERROR] = colors.error
    diagnosticColorsMap[vim.diagnostic.severity.WARN] = colors.warning
    diagnosticColorsMap[vim.diagnostic.severity.HINT] = colors.hint
    diagnosticColorsMap[vim.diagnostic.severity.INFO] = colors.info
    diagnosticColorsMap[-1] = STATUS_LINE_BACKGROUND_DARK

    local nextSeverity = getNextActiveSeverity(severity)
    if nextSeverity ~= -1 then
        return darkened(diagnosticColorsMap[nextSeverity])
    end

    -- If not, return the default background color for the status line
    return diagnosticColorsMap[-1]
end

--- Generates a component table for the given diagnostic
--- Note: This currently generates the table for a component showing up in the bottom right, and disappearing when
--- the diagnostic is not present in the current buffer.
--- @param severity vim.diagnostic.severity What severity this component will track
--- @param color string color of the component
--- @param icon string icon for the component
--- @return table componentTable The component table representing the component created
local function generateDiagnosticComponentTable(severity, color, icon)
    return {
        provider = function()
            local errors = vim.diagnostic.count(0)[severity];
            if errors ~= nil then
                return tostring(errors) .. ' '
            else
                return ''
            end
        end,
        hl = function()
            return {
                fg = color,
                bg = darkened(color),
                style = 'bold',
            }
        end,
        left_sep = function()
            return
            {
                str = 'left_rounded',
                hl = {
                    fg = darkened(color),
                    bg = getNextActiveSeverityColor(severity) -- Used so seperator colors are correct
                },
            }
        end,
        icon = {
            str = icon .. ' ',
            hl = {
                fg = color,
            },
        },
        name = 'diag' .. severity,
    }
end

--- Config function to be passed as the config function for the plugin (see lua/plugins/statusLine.lua)
function FelineConfig()
    local feline = require('feline')

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

    -- Table that contains all components
    local c = {
        vi_mode = {
            provider = {
                name = 'vi_mode',
                opts = { show_mode_name = true },
            },
            priority = 2,
            short_provider = function()
                return string.sub(require('feline.providers.vi_mode').get_vim_mode(), 1, 1)
            end,
            hl = function()
                return {
                    fg = util.darken(colors.dark3, 0.12), -- '#222436',
                    bg = require('feline.providers.vi_mode').get_mode_color(),
                    style = 'bold',
                    name = 'NeovimModeHLColor',
                }
            end,
            left_sep = 'block',
            right_sep = function()
                return {
                    str = '█',
                    hl = {
                        fg = require('feline.providers.vi_mode').get_mode_color(),
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
            priority = 1,
            short_provider = {
                name = 'file_info',
                opts = {
                    file_modified_icon = '󰝒',
                    file_readonly_icon = '󰈡',
                }
            },
            hl = {
                fg = STATUS_LINE_TEXT,
                bg = colors.dark3
            },
            left_sep = 'block',
            right_sep = {
                str = '█',
                hl = {
                    fg = STATUS_LINE_BACKGROUND,
                    bg = STATUS_LINE_BACKGROUND_DARK,
                },
            }
        },
        diagnostic_errors = generateDiagnosticComponentTable(vim.diagnostic.severity.ERROR, colors.error, ''),
        diagnostic_warnings = generateDiagnosticComponentTable(vim.diagnostic.severity.WARN, colors.warning, ''),
        diagnostic_hints = generateDiagnosticComponentTable(vim.diagnostic.severity.HINT, colors.hint, ''),
        diagnostic_info = generateDiagnosticComponentTable(vim.diagnostic.severity.INFO, colors.info, '󰋽'),
        -- The filename for nonactive buffers
        bland_file_name = {
            provider = {
                name = 'file_info',
                opts = {
                    file_modified_icon = '󰝒',
                    file_readonly_icon = '󰈡',
                },
            },
            short_provider = {
                name = 'file_info',
                opts = {
                    file_modified_icon = '󰝒',
                    file_readonly_icon = '󰈡',
                }
            },
            hl = {
                fg = colors.comment,
                bg = TERMINAL_BACKGROUND, -- Background color
            },
            left_sep = 'block',
        },
        line_percentage = {
            provider = 'line_percentage',
            hl = {
                fg = colors.black,
                bg = vi_mode_colors.NORMAL,
                style = 'bold',
            },
            right_sep = {
                str = 'block',
                hl = {
                    fg = vi_mode_colors.NORMAL,
                }
            },
            left_sep = {
                str = '█',
                hl = {
                    fg = vi_mode_colors.NORMAL,
                    bg = vi_mode_colors.INSERT,
                }
            },
        },
        bland_line_percentage = {
            provider = 'line_percentage',
            hl = {
                fg = colors.comment,
                bg = TERMINAL_BACKGROUND, -- Background color
            },
            right_sep = {
                str = ' ',
                hl = {
                    fg = colors.comment,
                    bg = TERMINAL_BACKGROUND, -- Background color
                },
            },
            left_sep = {
                str = ' ',
                hl = {
                    fg = colors.comment,
                    bg = TERMINAL_BACKGROUND, -- Background color
                },
            },
        },
        line_and_col = {
            provider = 'position',
            truncate_hide = true,
            priority = 4,
            hl = {
                fg = colors.black,
                bg = vi_mode_colors.INSERT,
                style = 'bold',
            },
            left_sep = {
                str = '█',
                hl = {
                    fg = vi_mode_colors.INSERT,
                    bg = STATUS_LINE_BACKGROUND,
                },
            },
            right_sep = {
                str = ' ',
                hl = {
                    fg = vi_mode_colors.NORMAL,
                    bg = vi_mode_colors.INSERT,
                }
            },
        },
        file_encoding = {
            provider = 'file_encoding',
            truncate_hide = true,
            priority = 4,
            hl = {
                fg = STATUS_LINE_TEXT,
                bg = colors.dark3,
            },
            left_sep = {
                str = '█',
                always_visible = false,
                hl = function()
                    return {
                        fg = STATUS_LINE_BACKGROUND,
                        bg = getNextActiveSeverityColor(5), -- 5 used so that it scans for all
                    }
                end,
            },
            right_sep = {
                str = ' ',
                hl = {
                    fg = vi_mode_colors.INSERT,
                    bg = STATUS_LINE_BACKGROUND,
                },
            },
        },
        bland_file_encoding = {
            provider = 'file_encoding',
            hl = {
                fg = colors.comment,
                bg = TERMINAL_BACKGROUND, -- Background color
            },
            right_sep = {
                str = ' /',
                hl = {
                    fg = colors.comment,
                    bg = TERMINAL_BACKGROUND, -- Background color
                },
            },
        },
        git_branch = {
            provider = function()
                local current_branch = vim.b.gitsigns_head
                if current_branch then
                    return '  ' .. current_branch .. ' '
                end
                return ''
            end,
            truncate_hide = true,
            priority = 3,
            hl = {
                fg = STATUS_LINE_TEXT,
                bg = STATUS_LINE_BACKGROUND_DARK,
            },
        },
        bland_git_branch = {
            provider = function()
                local current_branch = vim.b.gitsigns_head
                if current_branch then
                    return '  ' .. current_branch .. ' '
                end
                return ''
            end,
            truncate_hide = true,
            priority = 1,
            hl = {
                fg = colors.comment,
                bg = TERMINAL_BACKGROUND, -- Background color
            },
            left_sep = {
                str = ' /',
                hl = {
                    fg = colors.comment,
                    bg = TERMINAL_BACKGROUND, -- Background color
                },
            },
        }
    }

    -- Layout of components for the active buffer
    local active = {
        -- left
        {
            c.vi_mode,
            c.file_path,
            c.git_branch,
            { hl = { bg = STATUS_LINE_BACKGROUND_DARK } }
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
            c.file_encoding,
            c.line_and_col,
            c.line_percentage,
        }
    }

    -- Layout of compoonents for inactive buffers
    local inactive = {
        -- left
        {
            c.bland_file_name,
            c.bland_git_branch,
        },
        -- middle
        {

        },
        -- right
        {
            c.bland_file_encoding,
            c.bland_line_percentage,
        }
    }

    feline.setup({
        components = { active = active, inactive = inactive },
        vi_mode_colors = vi_mode_colors,
    })
end

-- Allows diagnostic components to be redrawn correctly as the diagnostic information changes
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    command = 'redrawstatus'
})

-- Return this table so that the plugin file can require this one and use this function as the config
return { FelineConfig = FelineConfig }
