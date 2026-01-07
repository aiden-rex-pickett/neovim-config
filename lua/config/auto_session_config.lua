return {
    cwd_change_handling = true,
    post_restore_cmds = {
        function()
            local root = vim.fs.root(0, { '.git' }) -- Change root markers here

            if root and root ~= vim.fn.getcwd() then
                vim.cmd("cd " .. root)
            end
        end
    }
}
