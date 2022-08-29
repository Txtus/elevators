local currentCreation = {
    ["points"] = {}
}
local points = {}
local markerpoints = {}

local handlemarkers = false
-- create the main menu
local ManageMainMenu = NativeUI.CreateMenu("Elevators", "~b~Create/Edit Elevatoes")
mP:Add(ManageMainMenu)

local createButton = NativeUI.CreateItem(trans["create_button"], trans["create_button_desc"])
local editButton = NativeUI.CreateItem(trans["edit_button"], trans["edit_button_desc"])

ManageMainMenu:AddItem(createButton)
ManageMainMenu:AddItem(editButton)


createButton.Activated = function(sender, item)
    debug("open create menu")
    openCreateMenu()
    currentCreation = {["points"] = {}}
end

editButton.Activated = function(sender, item)
    debug("open edit menu")
end

function openManageMainMenu()
    ManageMainMenu:Visible(true)
    mP:RefreshIndex()
    mP:MouseControlsEnabled (false)
    mP:MouseEdgeEnabled (false)
    mP:ControlDisablingEnabled(false)
end


-- open CreateMenu





function openCreateMenu()
    handlemarkers = true 
    handleMarkers()
    local currentpointcount = 1
    local CreateMenu = NativeUI.CreateMenu("Elevators", "~b~Create")
    mP:Add(CreateMenu)

    local setnameItem = NativeUI.CreateItem("Set Name", "Used in Database and in Floor selection")
    CreateMenu:AddItem(setnameItem)

    local AddPointItem = NativeUI.CreateItem("Add point", "Adds a point of the elevator")
    CreateMenu:AddItem(AddPointItem)

    local pointmenu = mP:AddSubMenu(CreateMenu, 'Edit Points', '')
    pointmenu.ParentItem:RightLabel("~o~>>>")

    setnameItem.Activated = function(sender, item) 
        local name = Dialog("Set name")
        debug(name)
        setnameItem:RightLabel("~g~"..name)
        currentCreation["elevatorName"] = name
    end

    AddPointItem.Activated = function(sender, item) 
        AddPointItem:RightLabel("Points: ~o~"..currentpointcount)
        local point = mP:AddSubMenu(pointmenu, 'Edit Point: '..currentpointcount, '')
        point.ParentItem:RightLabel("~o~>>>")
        print(point.ParentItem)
        points[currentpointcount] = {menuItem = point.ParentItem, pointnumber = currentpointcount}
        local SetCoordsItem = NativeUI.CreateItem("Set coords", "Adds current vector3 to the point")
        point:AddItem(SetCoordsItem)

        SetCoordsItem.Activated = function(sender, item)
            debug("Set Coords")
            local coords = GetEntityCoords(PlayerPedId())
            SetCoordsItem:RightLabel(tostring(coords):gsub('vector3', ''))
            for i=1, #points do 
                if points[i].menuItem == point.ParentItem then 
                    currentCreation["points"]["point:"..points[i].pointnumber] = {coords = coords}
                    markerpoints[points[i].pointnumber] = {coords = coords, number = points[i].pointnumber}
                    debug("Added Point: "..json.encode(currentCreation))
                end
            end
            
        end

        currentpointcount = currentpointcount+1
        mP:MouseControlsEnabled(false)
    end

   



    local placeholder = NativeUI.CreateItem("", "")
    CreateMenu:AddItem(placeholder)

    local deleteItem = NativeUI.CreateItem("~r~Delete", "")
    deleteItem:SetRightBadge(BadgeStyle.Alert)
    CreateMenu:AddItem(deleteItem)

    local saveItem = NativeUI.CreateItem("~g~Save", "")
    saveItem:SetRightBadge(BadgeStyle.Tick)
    CreateMenu:AddItem(saveItem)

    ManageMainMenu:Visible(false)
    CreateMenu:Visible(true)
    mP:RefreshIndex()
    mP:MouseControlsEnabled(false)
    mP:MouseEdgeEnabled(false)
    mP:ControlDisablingEnabled(false)
end

function handleMarkers()
    Citizen.CreateThread(function()
        while handlemarkers do 
            Citizen.Wait(0)
            for i=1, #markerpoints do 
                
                DrawMarker(20, markerpoints[i].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
            end
        end
    end)
end

openManageMainMenu()