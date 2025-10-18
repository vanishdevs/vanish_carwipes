--- @class entityEnumerator
local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

--- @param initFunc function Native FindFirst*
--- @param moveFunc function Native FindNext*
--- @param disposeFunc function Native EndFind*
--- @return fun(): number Iterator yielding entity IDs
local function enumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

--- @return fun(): number Iterator of object entity IDs
function enumerateObjects()
  return enumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

--- @return fun(): number Iterator of ped entity IDs
function enumeratePeds()
  return enumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

--- @return fun(): number Iterator of vehicle entity IDs
function enumerateVehicles()
  return enumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--- @return fun(): number Iterator of pickup entity IDs
function enumeratePickups()
  return enumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
