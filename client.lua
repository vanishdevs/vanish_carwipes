RegisterNetEvent("delallveh")
AddEventHandler("delallveh", function ()
    
	TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 10px; margin: 10px; background-color: rgba(202, 45, 45, 1); border-radius: 5px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); color: white; font-family: Arial, sans-serif; font-size: 20px; font-weight: bold; text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);"><i class="fas fa-car-crash"></i> {0}:<br> {1}</div>',
        args = { 'City Tow', 'A city car tow is coming in ' .. Config.timebeforecleanup .. ' minutes.' }
    })

    Citizen.Wait((Config.timebeforecleanup - 1) * 60 * 1000) -- Wait for 4 minutes
        
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 10px; margin: 10px; background-color: rgba(202, 45, 45, 1); border-radius: 5px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); color: white; font-family: Arial, sans-serif; font-size: 20px; font-weight: bold; text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);"><i class="fas fa-car-crash"></i> {0}:<br> {1}</div>',
        args = { 'City Tow', 'A city car tow is coming in 1 minute!  If you don\'t want your car to disappear, stay in the vehicle!' }
    })

	Citizen.Wait(1 * 60 * 1000) -- Wait for 1 minute
        
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 10px; margin: 10px; background-color: rgba(202, 45, 45, 1); border-radius: 5px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); color: white; font-family: Arial, sans-serif; font-size: 20px; font-weight: bold; text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);"><i class="fas fa-car-crash"></i> {0}:<br> {1}</div>',
        args = { 'City Tow', 'The city tow has been completed.' }
    })

end)