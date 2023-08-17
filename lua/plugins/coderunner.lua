local config = require "config"
return {
    {
        "michaelb/sniprun",
        cond = config.code_runner,
        cmd = "SnipRun",
        build = "bash install.sh"
    },
}
