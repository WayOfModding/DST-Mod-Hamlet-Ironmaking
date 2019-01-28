local _G = GLOBAL
local require = _G.require

local DEBUG = true

Assets =
{
}

PrefabFiles =
{
  "smelter",
  "alloy",
  "iron",
}

if DEBUG then
  local SpawnPrefab = _G.SpawnPrefab
  AddPlayerPostInit(function(inst)
    local function giveitem(item_name)
      local item = SpawnPrefab(item_name)
      if item then
        inst.components.inventory:GiveItem(item)
      end
    end

    -- Spawn items in tester's inventory
    if inst.components.inventory then
      giveitem("iron")
      giveitem("alloy")
    end
  end)
end
