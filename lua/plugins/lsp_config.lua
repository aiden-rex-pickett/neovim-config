return {
    -- lspconfig plugin --
{
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls" },
        })
    end
},
}
