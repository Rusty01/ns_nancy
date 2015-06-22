Script.Load("lua/SiegeMod/unstuck.lua")
Script.Load("lua/SiegeMod/FrontDoor.lua")
Script.Load("lua/SiegeMod/SiegeDoor.lua")
Script.Load("lua/SiegeMod/SizeTrigger.lua")
Script.Load("lua/ExtraEntitiesMod/PathingUtility_Modded.lua")
Script.Load("lua/ExtraEntitiesMod/PushTrigger.lua")
Script.Load("lua/ExtraEntitiesMod/GravityTrigger.lua")
Script.Load("lua/DoorMixin.lua")
Script.Load("lua/ExtraEntitiesMod/eem_ParticleEffect.lua")
Script.Load("lua/ExtraEntitiesMod/LogicWeldable.lua")
Script.Load("lua/ExtraEntitiesMod/TeleportTrigger.lua")
Script.Load("lua/ExtraEntitiesMod/FuncDoor.lua")
//Script.Load("lua/ExtraEntitiesMod/FuncObstacle.lua")
Script.Load("lua/ExtraEntitiesMod/PushTrigger.lua")
Script.Load("lua/ExtraEntitiesMod/LogicTimer.lua")
Script.Load("lua/ExtraEntitiesMod/LogicMultiplier.lua")
Script.Load("lua/ExtraEntitiesMod/LogicSwitch.lua")
Script.Load("lua/ExtraEntitiesMod/LogicFunction.lua")
Script.Load("lua/ExtraEntitiesMod/LogicDialogue.lua")
Script.Load("lua/ExtraEntitiesMod/LogicCounter.lua")
Script.Load("lua/SiegeMod/LogicTrigger.lua")
Script.Load("lua/ExtraEntitiesMod/LogicLua.lua")
Script.Load("lua/ExtraEntitiesMod/LogicEmitter.lua")
Script.Load("lua/ExtraEntitiesMod/LogicEmitterDestroyer.lua")
Script.Load("lua/ExtraEntitiesMod/LogicListener.lua")
Script.Load("lua/ExtraEntitiesMod/LogicButton.lua")
Script.Load("lua/ExtraEntitiesMod/LogicWorldTooltip.lua")
Script.Load("lua/ExtraEntitiesMod/LogicGiveItem.lua")
Script.Load("lua/ExtraEntitiesMod/LogicReset.lua")
Script.Load("lua/ExtraEntitiesMod/LogicBreakable.lua")
Script.Load("lua/ExtraEntitiesMod/LogicEventListener.lua")
Script.Load("lua/ExtraEntitiesMod/LogicCinematic.lua")
Script.Load("lua/ExtraEntitiesMod/LogicPowerPointListener.lua")
Script.Load("lua/ExtraEntitiesMod/GlobalEventListener.lua")
Script.Load("lua/ExtraEntitiesMod/eem_Utility.lua")
Script.Load("lua/ExtraEntitiesMod/FuncMoveable.lua")
Script.Load("lua/ExtraEntitiesMod/FuncPlatform.lua")
Script.Load("lua/ExtraEntitiesMod/FuncRotateable.lua")
Script.Load("lua/ExtraEntitiesMod/FuncTrain.lua")
Script.Load("lua/ExtraEntitiesMod/FuncTrainNoPushPull.lua")
Script.Load("lua/ExtraEntitiesMod/FuncTrainWaypoint.lua")



function CanEntityDoDamageTo(attacker, target, cheats, devMode, friendlyFire, damageType)

    if GetGameInfoEntity():GetState() == kGameState.NotStarted then
        return false
    end
   
    if not HasMixin(target, "Live") then
        return false
    end

    if not target:GetCanTakeDamage() then
        return false
    end
    
    if target == nil or (target.GetDarwinMode and target:GetDarwinMode()) then
        return false
    elseif cheats or devMode then
        return true
    elseif attacker == nil then
        return true
    end
    
    // You can always do damage to yourself.
    if attacker == target then
        return true
    end
    
    // Command stations can kill even friendlies trapped inside.
    if attacker ~= nil and attacker:isa("CommandStation") then
        return true
    end
    
    // Your own grenades can hurt you.
    if attacker:isa("Grenade") then
    
        local owner = attacker:GetOwner()
        if owner and owner:GetId() == target:GetId() then
            return true
        end
        
    end
    
    // Same teams not allowed to hurt each other unless friendly fire enabled.
    local teamsOK = true
    if attacker ~= nil then                                         ////Experiment to see if this makes logicbreakable attacked by both teams by tricking it ina way
        teamsOK = GetAreEnemies(attacker, target) or friendlyFire or (target:isa("LogicBreakable") and target:GetTeamNumber() == 0)
    end
    
    // Allow damage of own stuff when testing.
    return teamsOK
    
end


