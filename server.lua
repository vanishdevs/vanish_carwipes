-- Register manual cleanup command (permission-gated via config.command.restricted)
lib.addCommand('delallveh', {
  help = 'Deletes all vehicles on the server',
  restricted = config.command.restricted
}, function(source, args, raw)
  TriggerClientEvent('vanish_carwipes:startWipe', -1)
end)

--- @return integer Player count
local function playerCount()
  local players = GetPlayers()
  return players and #players or 0
end

--- @param periodic table Periodic scheduling config
local function triggerWipeIfAllowed(periodic)
  if periodic and tonumber(periodic.minPlayers) and playerCount() < tonumber(periodic.minPlayers) then
    print(('vanish_carwipes: skipped wipe (players %d < min %d)'):format(playerCount(), periodic.minPlayers))
    return
  end
  TriggerClientEvent('vanish_carwipes:startWipe', -1)
end

--- @param times table Array of time strings (e.g., {'06:00','12:00'})
--- @return boolean True if at least one valid time was scheduled
local function scheduleWithCron(times)
  local scheduled = false
  if type(times) ~= 'table' then return false end
  for _, t in ipairs(times) do
    if type(t) == 'string' then
      local hh, mm = t:match('^(%d%d?):(%d%d)$')
      hh, mm = tonumber(hh), tonumber(mm)
      if hh and mm and hh >= 0 and hh <= 23 and mm >= 0 and mm <= 59 then
        scheduled = true
        TriggerEvent('cron:runAt', hh, mm, function()
          triggerWipeIfAllowed(config.periodic)
        end)
      else
        print(('vanish_carwipes: invalid cron time "%s" (use HH:MM)'):format(t))
      end
    end
  end
  return scheduled
end

-- Periodic scheduling
do
  local periodic = config.periodic or {}
  if periodic.enabled then
    local scheduled = false
    if periodic.mode == 'cron' then
      -- Only if cron resource is available; otherwise we fall back to interval
      local ok = (type(GetResourceState) == 'function') and (GetResourceState('cron') == 'started')
      if ok then
        scheduled = scheduleWithCron(periodic.runAt)
        if scheduled then
          print('vanish_carwipes: periodic wipes scheduled via cron at: ' .. table.concat(periodic.runAt or {}, ', '))
        else
          print('vanish_carwipes: no valid cron times; falling back to interval scheduling')
        end
      else
        print('vanish_carwipes: cron not available; falling back to interval scheduling')
      end
    end

    if not scheduled then
      local minutes = tonumber(periodic.intervalMinutes) or 60
      if minutes < 1 then minutes = 1 end
      CreateThread(function()
        print(('vanish_carwipes: periodic wipes every %d minute(s)'):format(minutes))
        while true do
          Wait(minutes * 60 * 1000)
          triggerWipeIfAllowed(periodic)
        end
      end)
    end
  end
end
  
