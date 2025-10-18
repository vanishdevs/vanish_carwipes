lib.locale()
config = lib.load('shared.config.lua')

--- @param msg string Message body to display
--- @param source number|nil Player source (omit for client-side usage)
--- @return any Return value from lib.notify
function showNotification(msg, source)
    return source and lib.notify(source, {description = msg, position = 'center-right', type = 'inform'})
        or lib.notify({description = msg, position = 'center-right', type = 'inform'})
end
