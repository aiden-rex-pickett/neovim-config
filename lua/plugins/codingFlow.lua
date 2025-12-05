return {
-- Minipairs: just finishes ", {, etc. --
    {
        "nvim-mini/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            skip_unbalanced = true,
            markdown = true,
        }
    },

-- ts-comments: improve comment handling with treesitter --
-- (Handle multiple comment types, etc)
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy"
    },
}
