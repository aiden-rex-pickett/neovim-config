-- Yank Highlighting --
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end
})

-- Updates the cwd to be the root of the project, as per the markers defined below
local function changeToRootDirectory()
    local root = vim.fs.root(0, { '.git' }) -- Change root markers here

    if root and root ~= vim.fn.getcwd() then
        vim.cmd("cd " .. root)
    end
end

vim.api.nvim_create_autocmd('CmdlineEnter', { callback = changeToRootDirectory })

-- Remap 'Config' to go to config
vim.api.nvim_create_user_command(
    'Config',
    ':e $MYVIMRC',
    {}
)

return { changeToRootFunction = changeToRootDirectory }
