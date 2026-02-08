local colors = require('tokyonight.colors.night')

-- Line Number Things --
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.orange })

-- Indent Things --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Shorten tab width for HTML/CSS --
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"html", "css"},
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

-- Line Wrapping --
vim.opt.wrap = false
vim.opt.scrolloff = 4

-- Line Folding --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

-- Search Things --
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.schedule(function() vim.cmd("noh") end)
    end,
    desc = [[Clears search highlighting from '/' or '?'
            when entering insert mode. The search can still be
            traversed with 'n' and 'N' regardless]]
})
