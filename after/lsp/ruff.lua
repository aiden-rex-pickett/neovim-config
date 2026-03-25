return {
    on_attach = function(client, bufner)
        require("core.keymaps").lspAttachFunction(bufner)
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
