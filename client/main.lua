ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShSelinYannikTSonnysVateraredObjSelinYannikTSonnysVaterect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('life_basicneeds:resetStatus', function()
	TriggerEvent('life_status:set', 'hunger', 500000)
	TriggerEvent('life_status:set', 'thirst', 500000)
	TriggerEvent('life_status:set', 'h2o', 500000)
	TriggerEvent('life_status:set', 'zucker', 500000)
	TriggerEvent('life_status:set', 'fett', 500000)
	TriggerEvent('life_status:set', 'kcal', 500000)
end)

RegisterNetEvent('life_basicneeds:healPlayer')
AddEventHandler('life_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('life_status:set', 'hunger', 1000000)
	TriggerEvent('life_status:set', 'thirst', 1000000)
	TriggerEvent('life_status:set', 'h2o', 1000000)
	TriggerEvent('life_status:set', 'zucker', 1000000)
	TriggerEvent('life_status:set', 'fett', 1000000)
	TriggerEvent('life_status:set', 'kcal', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('life_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('life_status:loaded', function(status)

	TriggerEvent('life_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('life_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('life_status:registerStatus', 'zucker', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('life_status:registerStatus', 'kcal', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('life_status:registerStatus', 'h2o', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('life_status:registerStatus', 'fett', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)
local infinite = true
local wasser = false

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end
Citizen.CreateThread( function()
    while true do
       Citizen.Wait(0)
       RestorePlayerStamina(PlayerId(), 1.0)
	   setNoHurt()


       end
   end)
   
   
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('life_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					infinite = false				
				else
                    infinite = true				
				end
			end)

			TriggerEvent('life_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
				wasser = true
				else
				wasser = false
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('life_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('life_basicneeds:onEat')
AddEventHandler('life_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('life_basicneeds:onDrink')
AddEventHandler('life_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
setNotHurt()
		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)
