vim.opt.guifont = { "JetBrains\\ Mono\\ Nerd\\ Font", ":h16", ":#e-subpixelantialias" }

vim.g.neovide_title_background_color = string.format(
    "%x",
    tonumber(0x222436)
)

vim.g.neovide_remember_window_size = true

vim.g.neovide_scroll_animation_length = 0.3

vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
