local config = {
    on_attach = function(client, bufner)
        require('core.keymaps').lspAttachFunction(bufner)
        -- TODO: Maybe add more mappings for the jdtls specific functions, like extract method/constant type things?
        -- See Usage section of https://github.com/mfussenegger/nvim-jdtls
    end,

    name = "jdtls",

    cmd = { "jdtls" },

    root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', '.git' }),

    settings = {
        java = {
        }
    },
}

-- Done so that java files are automatically written when I stop typing
-- This way jdtls can be working on the properly updated version of the buffer
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    pattern = "*.java",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].modified and vim.bo[buf].buftype == "" then
            vim.cmd("silent! write")
        end
    end
})

require('jdtls').start_or_attach(config);
