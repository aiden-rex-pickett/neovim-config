-- Yank Highlighting --
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end
})

vim.api.nvim_create_user_command(
    "Config",
    ":e $MYVIMRC",
    {}
)
