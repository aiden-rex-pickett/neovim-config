local cmp = require("cmp")
local context = require("cmp.config.context")

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "files" }
    }),

    enabled = function ()
        return not context.in_treesitter_capture("comment")
    end
})
