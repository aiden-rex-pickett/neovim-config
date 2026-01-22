-- Yank Highlighting --
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end
})

-- AUTOCMDS --

--- Updates the cwd to be the root of the project, as per the markers defined below
local function changeToRootDirectory()
    local root = vim.fs.root(0, { '.git' }) -- Change root markers here

    if root and root ~= vim.fn.getcwd() then
        vim.cmd("cd " .. root)
    end
end

-- Changes to root whenever you go to type a command
vim.api.nvim_create_autocmd('CmdlineEnter', { callback = changeToRootDirectory })

-- Open up picker for sessions on launch with no file argument
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.schedule(function()
                vim.cmd("AutoSession search")
            end)
        end
    end
})

--- This function saves a session with auto session only if the actual cwd matches with the
--- session name (Which should be the cwd), upon being called.
--- @param args vim.api.keyset.create_autocmd.callback_args
local function saveSessionIfInCorrectCwd(args)
    local session_cwd = string.gsub(require('auto-session.lib').current_session_name(), '\\', '/')
    local current_cwd = string.gsub(args.file, '\\', '/')
    if vim.bo.filetype == "netrw" or vim.bo.buftype == "terminal" or args.file == "" then return end
    if session_cwd == string.sub(current_cwd, 1, #session_cwd) then
        require('auto-session').save_session()
    end
end

-- Save session upon leaving/quitting
vim.api.nvim_create_autocmd({ 'BufLeave', 'QuitPre' }, {
    callback = saveSessionIfInCorrectCwd,
})


-- REMAPS --

-- Remap 'Config' to go to config
vim.api.nvim_create_user_command(
    'Config',
    ':e $MYVIMRC',
    {}
)

return { changeToRootFunction = changeToRootDirectory, saveWithCheckFunction = saveSessionIfInCorrectCwd } -- returned for use in plugins
