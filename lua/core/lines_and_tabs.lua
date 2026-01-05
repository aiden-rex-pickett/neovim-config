-- Line Number Things --
vim.o.number = true
vim.o.relativenumber = true

-- Indent Things --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line Wrapping --
vim.opt.wrap = false
vim.opt.scrolloff = 4

-- Line Folding --
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99

-- Search Things --
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.schedule(function () vim.cmd("noh") end)
    end,
    desc = [[Clears search highlighting from '/' or '?' 
            when entering insert mode. The search can still be
            traversed with 'n' and 'N' regardless]]
})
