RegisterCommand(Config.command, function(source, args, rawCommand) TriggerClientEvent("delallveh", -1) end, Config.admincommand)

-- Use if using essential mode
--[[
TriggerEvent('es:addGroupCommand', Config.command, 'changeme', function(source, args, user)
		TriggerClientEvent("delallveh", -1)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "/delallveh"})
]]

function CleanUpCronTask(d, h, m)
	TriggerClientEvent("delallveh", -1)
end

if Config.cleanuptime == 30 then
    TriggerEvent('cron:runAt', 0, 30, CleanUpCronTask)   
    TriggerEvent('cron:runAt', 1, 30, CleanUpCronTask)    
    TriggerEvent('cron:runAt', 2, 30, CleanUpCronTask)  
    TriggerEvent('cron:runAt', 3, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 4, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 5, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 6, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 7, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 8, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 9, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 10, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 11, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 12, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 13, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 14, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 15, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 16, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 17, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 18, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 19, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 20, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 21, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 22, 30, CleanUpCronTask)
    TriggerEvent('cron:runAt', 23, 30, CleanUpCronTask)
end
