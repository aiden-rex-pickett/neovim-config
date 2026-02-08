return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.1',
    Lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = require("config.telescope_config")
}
