--- @module "auto-session"
--- @class AutoSession.Config
return {
    cwd_change_handling = true,
    post_restore_cmds = {
        require('core.custom_commands').changeToRootFunction
    },
}
