

local Config = {}
local Is_JS_Load = false

Config.Use_Custom_Wait_Function = false
Config.Custom_Wait_Function = function()
    --[[
        (Do Wait)
        Example:
            while not Spawned do
                Wait(1)
            end
        Other Example:
            Wait(2000)
    ]]
end


function Show_Tasliat()
    SendNUIMessage({
        type = "Show_Tasliat",
    })
	SetNuiFocus(true, true)
end

function Close_Tasliat()
    SendNUIMessage({
        type = "Close_Tasliat",
    })
	SetNuiFocus(false, false)
end

CreateThread(function()
	while not NetworkIsSessionActive() or not NetworkIsSessionStarted() do
		Wait(0)
	end
    while not Is_JS_Load do
        Wait(0)
    end
    if Config.Use_Custom_Wait_Function then
        Config.Custom_Wait_Function()
    end
    Show_Tasliat()
end)



RegisterNUICallback("datas", function(data)
    if data["JS_Started"] == true then
        Is_JS_Load = true
    elseif data["Close"] == true then
        Close_Tasliat()
    end
end)





