-- Yank Highlighting --
vim.api.nvim_create_autocmd("TextYankPost", {callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200})
    end
})

-- Update CWD to be the buffers directory when you open a new buffer --
vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Update CWD to be buffers dierctory",
    callback = function ()
        vim.cmd("silent! lcd %:h")
    end
})

-- Edit Config Shorthand --
vim.api.nvim_create_user_command(
    "Config",
    ":e $MYVIMRC",
    {}
)
