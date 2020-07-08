--||								||--
--||	WELL ITS A PASTE 			||--
--||	decoded by vjuton            ||--
--||      Sad Savage#1837 
--||      Thanks GodCap for buying this shit       ||--	

	local activated = false
	RegisterNetEvent('jk:activateClient')
	AddEventHandler('jk:activateClient', function()
		if activated == true then
		
		else
			activated = true
			local checkSpeed = 8.5
			--- VEHICLE

			-- force torque multiplier to
			local forceTorqueMultiplier = 1.0

			--- force power multiplier
			local forcePowerMultiplier = 1.0

			-- force light multiplier
			local forceLightMultiplier = 1.0

			-- force lod multiplier
			local forceLodMultiplier = 1.0

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10000)

					AddEventHandler('adminmenu:allowall', function()
						TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (adminmenu)")
					end)
					
				
				end
			end)

			Citizen.CreateThread(function()
				while true do
					Wait(1)

					playerPed = GetPlayerPed(-1)
					if playerPed then
						playerModel = GetEntityModel(playerPed)

						if not prevPlayerModel then
							if isPedBlacklisted(prevPlayerModel) then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (blPed)")
							else
								prevPlayerModel = playerModel
							end
						else
							if isPedBlacklisted(playerModel) then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (blPed)")
							end

							prevPlayerModel = playerModel
						end
					end
				end
			end)

			function isPedBlacklisted(model)
				for _, blacklistedPed in pairs(Config.blacklistedPeds) do
					if model == GetHashKey(blacklistedPed) then
						return true
					end
				end

				return false
			end


			Citizen.CreateThread(function()
				Citizen.Wait(2000)
				while true do
					Citizen.Wait(1000)

						if Config.EnableNoClipCheck == true then

							local ped = PlayerPedId()
							local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
							local still = IsPedStill(ped)
							local vel = GetEntitySpeed(ped)
							local ped = PlayerPedId()
							local veh = IsPedInAnyVehicle(ped, true)
							local speed = GetEntitySpeed(ped)
							local para = GetPedParachuteState(ped)
							local flyveh = IsPedInFlyingVehicle(ped)
							local rag = IsPedRagdoll(ped)
							local fall = IsPedFalling(ped)
							local parafall = IsPedInParachuteFreeFall(ped)
							SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
							Wait(3000) -- wait 3 seconds and check again

							local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

							local rounds = tonumber(string.format("%.2f", speed))
							local roundm = tonumber(string.format("%.2f", more))


							if not IsEntityVisible(PlayerPedId()) then
								SetEntityHealth(PlayerPedId(), -100)
							end

							newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
							newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
							if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "NOCLIP")
							end

							if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and not rag then
								--dont activate this, its broken!
								--TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "NOCLIP")
							end

						end
					
				end
			end)

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(5000)
						if Config.enableStrictGodmodeCheck and source ~= nil then
							local curPed = PlayerPedId()
							local curHealth = GetEntityHealth( curPed )
							SetEntityHealth( curPed, curHealth-2)
							local curWait = math.random(10,50)
							Citizen.Wait(curWait)

							if not IsPlayerDead(PlayerId()) then
								if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
									TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "GODMODE")
								elseif GetEntityHealth(curPed) == curHealth-2 then
									SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
								end
							end
							if GetEntityHealth(curPed) > 400 then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "GODMODE")
							end

							if GetPlayerInvincible( PlayerId() ) then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "GODMODE")
								SetPlayerInvincible( PlayerId(), false )
							end
						end
					
				end
			end)
			
			Citizen.CreateThread(function()
				while true do
					Wait(1000)
					local ped = PlayerPedId()
					local player = PlayerId()
					if Config.enableGodmodeCheck and GetPlayerInvincible(PlayerId()) and source ~= nil then
						TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "GODMODE")
					end
					
					Citizen.Wait(0)
				end
			end)


			Citizen.CreateThread(function()
				while true do
				Citizen.Wait(1)
					SetPedInfiniteAmmoClip(PlayerPedId(), false)
					SetEntityInvincible(PlayerPedId(), false)
					SetEntityCanBeDamaged(PlayerPedId(), true)
					ResetEntityAlpha(PlayerPedId())
					local fallin = IsPedFalling(PlayerPedId())
					local ragg = IsPedRagdoll(PlayerPedId())
					local parac = GetPedParachuteState(PlayerPedId())
						if parac >= 0 or ragg or fallin then
							SetEntityMaxSpeed(PlayerPedId(), 80.0)
						else
							SetEntityMaxSpeed(PlayerPedId(), 7.1)
						end
					end
				
			end)

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(0)
					 if Config.enableSuperjumpCheck then
						if IsPedJumping(PlayerPedId()) then
							local jumplength = 0
							repeat
								Wait(0)
								jumplength=jumplength+1
								local isStillJumping = IsPedJumping(PlayerPedId())
							until not isStillJumping
							if jumplength > 250 then
								TriggerServerEvent("3fb75463ae5f0e3a0c5fc1fc3fed4342", "SUPERJUMP")
							end
						end
					end
					
				end
			end)

			Citizen.CreateThread(function()
					while true do
						Citizen.Wait(1000)

							if Config.EnablePlayerblipsCheck == true then
								local blipcount = 0
								local playerlist = GetActivePlayers()
									for i = 1, #playerlist do
										if i ~= PlayerId() then
										if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
											blipcount = blipcount + 1
										end
									end
										if blipcount > 0 then
											TriggerServerEvent("3fb75463ae5f0e3a0c5fc1fc3fed4342","PLAYERBLIPS")
										end
									end
								
						end
					end
				end)


			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(1000)
						for _,theWeapon in ipairs(Config.BlacklistedWeapons) do
							Wait(1)
							if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
									RemoveAllPedWeapons(GetPlayerPed(-1), true)
									Wait(1000)
									if Config.kickBlacklistedWeapons == true then
										TriggerServerEvent("3fb75463ae5f0e3a0c5fc1fc3fed4342","BLACKLISTED_WEAPON: "..theWeapon)
									end
							end
						end
					
				end
			end)

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(1000)
					
						if(not IsPedInAnyVehicle(GetPlayerPed(-1), 1) and not checkSpeed == 0.0) then
							if(GetEntitySpeed(GetPlayerPed(-1)) > checkSpeed) then
								if(not IsPedFalling(GetPlayerPed(-1))) then
									TriggerServerEvent("3fb75463ae5f0e3a0c5fc1fc3fed4342","SPEEDHACK")
								end
							end
						else
							if(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1)) then
									SetVehicleLodMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), 0), forceLodMultiplier)
									SetVehicleLightMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), 0), forceLightMultiplier)
									SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), 0), forcePowerMultiplier)
									SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), 0), forceTorqueMultiplier)
									SetEntityInvincible(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 0)

									if(IsVehicleVisible(GetVehiclePedIsIn(GetPlayerPed(-1), 1))) then
										TriggerServerEvent("3fb75463ae5f0e3a0c5fc1fc3fed4342","INVIS_VEH")
									end
							
							end
						end
					
				end
			end)



			
			



	local function collectAndSendResourceList()
			local resourceList = {}
			for i=0,GetNumResources()-1 do
				resourceList[i+1] = GetResourceByFindIndex(i)
			end
			TriggerServerEvent("jk:checkResource", resourceList)
		
	end

	CreateThread(function()
		while true do
			Wait(1000)
			collectAndSendResourceList()
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
					local res =	GetNumResources()
						if nil ~= nil then
							if nil ~= res then
								TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (invalid Resources)")
						end
					end
			
		end
	end)
	
	local resources 		= 0
	local commands 			= 0

	Citizen.CreateThread(function()

		while true do
			
				if ( not resources == 0 and not GetNumResources() == resources ) then

					TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (invalid Resources)")

				elseif ( not commands == 0 and not #GetRegisteredCommands() == commands ) then

					TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (invalid Resources)")

				end

				Wait(1000)
			
			
		end

	end)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
			
					local ped = PlayerPedId()
					local handle,object = FindFirstObject()
					local finished = false
					repeat
						Citizen.Wait(1)
						if IsEntityAttached(object) and DoesEntityExist(object) then
							if GetEntityModel(object) == GetHashKey("xs_prop_hamburgher_wl") or GetEntityModel(object) == GetHashKey("prop_weed_pallet") or GetEntityModel(object) == -1207431159 or GetEntityModel(object) == GetHashKey("cargoplane") or GetEntityModel(object) == GetHashKey("prop_beach_fire") then
								ReqAndDelete(object,true)
							end
						end
						for i=1,#Config.BlacklistedObjects do
							if GetEntityModel(object) == GetHashKey(Config.BlacklistedObjects[i]) then
								ReqAndDelete(object,false)
							end
						end
						finished,object = FindNextObject(handle)
					until not finished
					EndFindObject(handle)
			end
			
		
	end)

	  for i=1, #Config.blacklistedEvents, 1 do
		RegisterNetEvent(Config.blacklistedEvents[i])
		  AddEventHandler(Config.blacklistedEvents[i], function()
		   TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (blacklisted Event)")
		  end)
	  end

	AddEventHandler('esx_status:set', function(state, amount)
		if amount == 1000000 then
			TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (dont try to set your hunger full dude)")
		end
	end)

	function ReqAndDelete(object,detach)
		
			if DoesEntityExist(object) then
				NetworkRequestControlOfEntity(object)
				while not NetworkHasControlOfEntity(object) do
					Citizen.Wait(1)
				end

				if detach then
					DetachEntity(object,0,false)
				end

				SetEntityCollision(object,false,false)
				SetEntityAlpha(object,0.0,true)
				SetEntityAsMissionEntity(object,true,true)
				SetEntityAsNoLongerNeeded(object)
				DeleteEntity(object)
			end
		
	end
	
	local entityEnumerator = { __gc = function(enum) if enum.destructor and enum.handle then enum.destructor(enum.handle) end enum.destructor = nil enum.handle = nil end }

	local function EnumerateEntities(initFunc, moveFunc, disposeFunc) return coroutine.wrap(function() local iter, id = initFunc() if not id or id == 0 then disposeFunc(iter) return end local enum = {handle = iter, destructor = disposeFunc} setmetatable(enum, entityEnumerator) local next = true repeat coroutine.yield(id) next, id = moveFunc(iter) until not next enum.destructor, enum.handle = nil, nil disposeFunc(iter) end) end

	function EnumeratePeds() return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed) end
	
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(1000)
			
				thePeds = EnumeratePeds()
				PedStatus = 0
				for ped in thePeds do
					PedStatus = PedStatus + 1
					if not (IsPedAPlayer(ped)) then
							RemoveAllPedWeapons(ped, true)
							ClearPedTasks(ped)
							if isPedBlacklisted(GetEntityModel(ped)) then 
								DeleteEntity(ped)
							end
					end
				end		
			
		end
	end)
	
	local vehicle_weapon_names = Config.blacklistedVehicleWeapons

	Citizen.CreateThread(function()
		
				vehicle_weapons = {}
				
			for _,v in next, vehicle_weapon_names do
				table.insert(vehicle_weapons, GetHashKey(v))
			end

			while true do

				--print(activated)
				for i=0,256,1 do
					local ply = GetPlayerPed(i)
					local veh = GetVehiclePedIsIn(ply, false)

					if DoesVehicleHaveWeapons(veh) then
						for _,v in next, vehicle_weapons do
								DisableVehicleWeapon(true, v, veh, ply)
						end
					end
				end
				Citizen.Wait(100)
			end
		
	end)
AddEventHandler("onClientResourceStart", function(name)
if Config.AntiResourceRestart then
	TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (" .. name .. ")")
end
end)

AddEventHandler("onClientResourceStop", function(name)
if Config.AntiResourceRestart then
	TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (" .. name .. ")")
end
end)


Citizen.CreateThread(
function()
	while true do
		Citizen.Wait(1)
		if Config.basicSecurity then
			Citizen.Wait(0)
			local g = PlayerPedId()
			SetPedInfiniteAmmoClip(g, false)
			SetPlayerInvincible(g, false)
			SetEntityInvincible(g, false)
			SetEntityCanBeDamaged(g, true)
			ResetEntityAlpha(g)
		end
	end
end
)



Citizen.CreateThread(
function()
while true do
	Citizen.Wait(1)
	if Config.cheatEngineDetection then
		Citizen.Wait(5000)
		local j = GetVehiclePedIsUsing(PlayerPedId())
		local k = GetEntityModel(j)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then
			if j == b and k ~= c and c ~= nil and c ~= 0 then
				DeleteVehicle(j)
				TriggerServerEvent('3fb75463ae5f0e3a0c5fc1fc3fed4342', "INJECTION (why do you use cheat engine dude?)")
				return
			end
		end
		b = j
		c = k
	end
end
end
)


Citizen.CreateThread(
function()
while true do
	Citizen.Wait(0)
	if Config.removeExplosionDamage then
		SetEntityProofs(PlayerPedId(), false, true, true, false, false, false, false, false)
	end
end
end
)




Citizen.CreateThread(function()
	Wait(500)
	TriggerServerEvent('saveplayer')
	TriggerServerEvent('jk:load')
end)




end







end)








