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

require('jdtls').start_or_attach(config);
