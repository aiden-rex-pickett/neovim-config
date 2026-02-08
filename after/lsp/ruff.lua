return {
    on_attach = function(client, bufner)
        require("core.keymaps").attachFunction(bufner)
    end,
    init_options = {
        settings = {
            configurationPreference = "editorFirst",
            -- Formatter stuff goes here
            configuration = {
                ['indent-width'] = 4,
                ['line-length'] = 80,
                format = {
                    ['quote-style'] = "double",
                }
            }
        }
    }
}
