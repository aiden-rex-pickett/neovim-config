return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    Lazy = false,
    config = function ()
        require("todo-comments").setup()
    end
}
