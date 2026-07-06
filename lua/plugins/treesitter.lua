return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = "VeryLazy",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc", "c" },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            fold = { enable = true },
            auto_install = true,
        },
        config = function(_, opts)
            require("nvim-treesitter.install").compilers = { "gcc" }
            require("nvim-treesitter.config").setup(opts)
        end,
    },
}
