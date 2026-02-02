-- Leader Key --
vim.g.mapleader = " "

function MapNorm(keymapping, result, description)
    vim.keymap.set("n", keymapping, result, { desc = description } or nil)
end

-- Directory listing keymaps --
MapNorm("<leader>dl", vim.cmd.Ex, "Open netrw for the current file")

-- Window movement keymaps --
MapNorm("<leader>wh", "<C-w>h", "move left by a window")
MapNorm("<leader>wj", "<C-w>j", "move down by a window")
MapNorm("<leader>wk", "<C-w>k", "move up by a window")
MapNorm("<leader>wl", "<C-w>l", "move right by a window")

local telescope_builtin = require('telescope.builtin')
local saveWithCheck = require('core.custom_commands').saveWithCheckFunction
-- Telescope bindings --
MapNorm("<leader>ff", telescope_builtin.find_files, "Find files in telescope")
MapNorm("<leader>fs", function()
        saveWithCheck({ file = vim.fn.expand("%:p") })
    vim.cmd("AutoSession search")
end, "Search sessions with telescope") -- Not exactly telescope related but makes sense here

-- Splitting keymaps --
MapNorm("<leader>ws", vim.cmd.split, "create a split window")
MapNorm("<leader>wv", vim.cmd.vsplit, "create a vertical split window")
MapNorm("<leader>w=", function() vim.cmd("vertical resize +4") end, "move vertical dividing line to the right")
MapNorm("<leader>w-", function() vim.cmd("vertical resize -4") end, "move vertical dividing line to the left")
MapNorm("<leader>w+", function() vim.cmd("resize +4") end, "move horizontal dividing line to down")
MapNorm("<leader>w_", function() vim.cmd("resize -4") end, "move horizontal dividing line to up")

-- Convience overrides --
MapNorm("<C-d>", function()
    vim.cmd("normal " .. vim.wo.scroll .. "j"); vim.cmd("normal zz")
end, "center cursor as you move half page down")
MapNorm("<C-u>", function()
    vim.cmd("normal " .. vim.wo.scroll .. "k"); vim.cmd("normal zz")
end, "center cursor as you move half page up")

-- LSP keymaps --
-- This is the default keymaps that all servers use --
function DefaultKeymaps(bufnr)
    local options = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options)
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, options)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, options)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, options)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, options)
    vim.keymap.set("n", "<leader>le", vim.diagnostic.setloclist, options)
    vim.keymap.set("n", "<leader>ne", function()
        vim.diagnostic.jump({ count = 1 })
        vim.defer_fn(vim.diagnostic.open_float, 30)
    end, options)
    vim.keymap.set("n", "<leader>Ne", function()
        vim.diagnostic.jump({ count = -1 })
        vim.defer_fn(vim.diagnostic.open_float, 30)
    end, options)
end

MapNorm("<leader>e", vim.diagnostic.open_float, "Open diagnostic window")

-- Nvim-Cmp keymaps --
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-b>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.scroll_docs(-4),
        ["<Esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.close()
            end
            fallback()
        end
        ),
    })
})

return { attachFunction = DefaultKeymaps }
