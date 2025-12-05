return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").compilers = { "zig" }
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "c" },
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = true },
                fold = { enable = true },
                auto_install = true,
            })
        end,
    },
    { "nvim-treesitter/playground" },
}
