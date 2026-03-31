return {
    -- Luasnip, snippet engine --
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        event = "VeryLazy"
        -- This will eventually fix the slow startup and allow for
        -- better lsp integration when I figure it out:
        -- build = "make install_jsregexp CC=gcc",
    },

    -- nvim-cmp, completion engine --
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
        },
    },
}
