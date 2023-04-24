local taskInProcess = false

function openGui(time)
    SetNuiFocus(true, false)
    SendNUIMessage({type = "open", time = time})
end

function closeMenu(type)
    SetNuiFocus(false, false)
    status = type
    taskInProcess = false
     SetNuiFocus(false, false)
end

function taskBar(difficulty)
    if taskInProcess then return end
    taskInProcess = true
    openGui(difficulty)
    while taskInProcess do 
        if IsPedRagdoll(GetPlayerChar(-1)) then 
            SetNuiFocus(false, false)
            SendNUIMessage({type = "close"})
            taskInProcess = false
            return false
        end
        Citizen.Wait(0) 
    end
    Citizen.Wait(200)
    if status == "success" then
        return true
    else
        return false
    end
end

RegisterNetEvent('SkillCheck')
AddEventHandler('SkillCheck', function()
    taskBar(20000)
end)

RegisterNetEvent('CloseSkillCheck')
AddEventHandler('CloseSkillCheck', function(ty)
    if(ty == 'suc') then
        closeMenu("success")
    else
        closeMenu("fail")
    end
end)