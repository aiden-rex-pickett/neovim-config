vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    "rmagatti/auto-session",
    lazy = false,
    opts = require('config.auto_session_config')
}
