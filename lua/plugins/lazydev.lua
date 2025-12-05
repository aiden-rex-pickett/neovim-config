return {
    "folke/lazydev.nvim",
    ft = "lua",
    event = "VeryLazy",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } }
        }
    }
}
