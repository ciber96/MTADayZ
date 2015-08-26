--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: backpack_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

elementBackpack = {}
function addBackpackToPlayer(dataName,oldValue)
	if getElementType(source) == "player" and dataName == "MAX_Slots" then
		local newValue = getElementData(source,dataName)
		if elementBackpack[source] then
			detachElementFromBone(elementBackpack[source])
			destroyElement(elementBackpack[source])
			elementBackpack[source] = false
		end
		local x,y,z = getElementPosition(source)
		local rx,ry,rz = getElementRotation(source)
		if newValue == 12 then
			elementBackpack[source] = createObject(3026,x,y,z) -- acu
		elseif newValue == 13 then
			elementBackpack[source] = createObject(1248,x,y,z) -- ALICE
		elseif newValue == 16 then
			elementBackpack[source] = createObject(3026,x,y,z) -- Placeholder
		elseif newValue == 17 then
			elementBackpack[source] = createObject(1644,x,y,z) -- OS
		elseif newValue == 18 then
			elementBackpack[source] = createObject(1275,x,y,z) -- Ghillie
		elseif newValue == 24 then
			elementBackpack[source] = createObject(1252,x,y,z) -- Coyote
		elseif newValue == 30 then
			elementBackpack[source] = createObject(1575,x,y,z) -- Czech
		elseif newValue == 8 then
			return
		end
		if newValue == 30 then
			attachElementToBone(elementBackpack[source],source,3,0,-0.16,0.05,270,0,180)
		else
			attachElementToBone(elementBackpack[source],source,3,0,-0.225,0.05,90,0,0)
		end
	end	
end
addEventHandler ("onElementDataChange", root, addBackpackToPlayer)

function backpackRemoveQuit ()
	if elementBackpack[source] then
		detachElementFromBone(elementBackpack[source])
		destroyElement(elementBackpack[source])
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end	
end
addEventHandler ( "onPlayerQuit", getRootElement(), backpackRemoveQuit )

elementWeaponBack = {}
function weaponSwitchBack ( previousWeaponID, currentWeaponID )
	local weapon1 = getElementData(source,"currentweapon_1")
	if not weapon1 then return end
	local ammoData1,weapID1 = getWeaponAmmoFromName(weapon1)
	local x,y,z = getElementPosition(source)
	local rx,ry,rz = getElementRotation(source)
	if previousWeaponID == weapID1 then
		if elementWeaponBack[source] then
			detachElementFromBone(elementWeaponBack[source])
			destroyElement(elementWeaponBack[source])
			elementWeaponBack[source] = false
		end
		elementWeaponBack[source] = createObject(getWeaponObjectID(weapID1),x,y,z)
		setObjectScale(elementWeaponBack[source],0.875)
		if elementBackpack[source] then
			attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.31,-0.1,0,270,-90)
		else
			attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.11,-0.1,0,270,10)
		end
	elseif currentWeaponID == weapID1 then
		detachElementFromBone(elementWeaponBack[source])
			if elementWeaponBack[source] then
				destroyElement(elementWeaponBack[source])
			end
		elementWeaponBack[source] = false
	end
end
addEventHandler ( "onPlayerWeaponSwitch", getRootElement(), weaponSwitchBack )

function removeBackWeaponOnDrop ()
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end
end
addEvent("removeBackWeaponOnDrop",true)
addEventHandler("removeBackWeaponOnDrop",getRootElement(),removeBackWeaponOnDrop)

function removeAttachedOnDeath ()
	if elementBackpack[source] then
		detachElementFromBone(elementBackpack[source])
		destroyElement(elementBackpack[source])
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end	
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),removeAttachedOnDeath)