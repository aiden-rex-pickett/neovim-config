vim.o.guifont = "JetBrainsMono Nerd Font Mono:h18"

vim.g.neovide_title_background_color = string.format(
    "%x",
    tonumber(0x222436)
)

vim.g.neovide_remember_window_size = true

vim.g.neovide_scroll_animation_length = 0.4

vim.g.neovide_fullscreen = 1

vim.keymap.set('n', '<F11>', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end)

vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
