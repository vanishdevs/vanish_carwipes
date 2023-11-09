Config = {
    -- Command Configuration
    command = "delallveh", -- Change this command to perform manual cleanup.
    admincommand = true, -- Set to false to allow anyone on the server to start the clean up, or set to true and add the following line in your server.cfg: "add_ace group.admin command.delallveh allow".
    -- Cleanup Configuration
    cleanuptime = 30,
    timebeforecleanup = 2 -- Minutes
}
