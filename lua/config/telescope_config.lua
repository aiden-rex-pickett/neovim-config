local function telescopeConfigure()
    local telescope = require('telescope')
    telescope.setup {
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {

                }
            }
        }
    }
    print("HELEKJLEKJE")
    telescope.load_extension("ui-select")
end

return telescopeConfigure
