mP = NativeUI.CreatePool()
trans = Translation[Config.language]
elevators = {}
CurrentFloor = {}

function Dialog(msg)
    local Text = msg
    AddTextEntry(Text, Text)
    DisplayOnscreenKeyboard(1, Text, "", "", "", "", "", 10 + 1) 
    while(UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if(GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        return result
    end 
end
            



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if mP:IsAnyMenuOpen() then 
            mP:ProcessMenus()
        else
            Citizen.Wait(410)
        end
    end
end)





