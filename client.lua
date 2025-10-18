--- @param minutes number Minutes to convert
--- @return number Milliseconds
local function totalMsFromMinutes(minutes)
  local m = tonumber(minutes) or 0
  if m < 1 then m = 1 end
  return m * 60 * 1000
end

--- @param vehicle number Entity ID for the vehicle
--- @param key string Decor name
--- @return boolean True if decor exists and is true
local function hasTrueDecor(vehicle, key)
  return DecorExistOn(vehicle, key) and DecorGetBool(vehicle, key)
end

--- @param vehicle number Entity ID for the vehicle
--- @return boolean True if vehicle should be excluded
local function excludeVehicles(vehicle)
  return hasTrueDecor(vehicle, "boostVehicle") or hasTrueDecor(vehicle, "jobVehicle")
end

--- @param entity number Entity ID
--- @param tries number|nil Max attempts (defaults to 25)
--- @return boolean True if control was obtained
local function ensureControl(entity, tries)
  local i = 0
  while not NetworkHasControlOfEntity(entity) and i < (tries or 25) do
    NetworkRequestControlOfEntity(entity)
    Wait(10)
    i = i + 1
  end
  return NetworkHasControlOfEntity(entity)
end

--- @param vehicle number Entity ID for the vehicle
local function deleteVehicleSafely(vehicle)
  if not DoesEntityExist(vehicle) or not IsEntityAVehicle(vehicle) then return end
  ensureControl(vehicle, 25)
  SetVehicleHasBeenOwnedByPlayer(vehicle, false)
  SetEntityAsMissionEntity(vehicle, true, true)
  DeleteVehicle(vehicle)
  if DoesEntityExist(vehicle) then
    DeleteEntity(vehicle)
  end
end

--- @return void
local function startWipe()
  local minutes = (config and config.timeBeforeWipe) or 5 -- fallback to 5 minutes
  local total = totalMsFromMinutes(minutes)

  local function sanitizeStages(list)
    local set, arr = {}, {}
    if type(list) == 'table' then
      for _, v in ipairs(list) do
        if type(v) == 'number' and v > 0 and v < 1 and not set[v] then
          set[v] = true
          arr[#arr + 1] = v
        end
      end
    end
    if #arr == 0 then arr = { 0.5, 0.25, 0.10 } end
    table.sort(arr, function(a, b) return a > b end)
    return arr
  end

  local warnCfg = (config and config.warnings) or { enabled = true, stages = { 0.5, 0.25, 0.10 } }
  local warnEnabled = warnCfg.enabled ~= false

  if warnEnabled then
    local userStages = sanitizeStages(warnCfg.stages)
    local timeline = { 1.0 }
    for i = 1, #userStages do timeline[#timeline + 1] = userStages[i] end
    timeline[#timeline + 1] = 0.0

    for i = 1, #timeline - 1 do
      local delta = timeline[i] - timeline[i + 1]
      if delta > 0 then Wait(math.floor(total * delta)) end
      if timeline[i + 1] > 0 then
        local remainingMinutes = math.ceil((total * timeline[i + 1]) / 60000)
        showNotification(locale("warnings", remainingMinutes))
      end
    end
  else
    Wait(total)
  end

  for vehicle in enumerateVehicles() do
    if IsVehicleSeatFree(vehicle, -1) and not excludeVehicles(vehicle) then
      deleteVehicleSafely(vehicle)
    end
  end
  showNotification(locale('complete'))
end

RegisterNetEvent('vanish_carwipes:start_wipe')
AddEventHandler('vanish_carwipes:start_wipe', startWipe)
