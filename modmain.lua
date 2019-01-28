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

-- Bybass nil function and variables
_G.MakeBlowInHurricane = function(...)
end
_G.MakeInventoryFloatable = function(...)
end
_G.TUNING.WINDBLOWN_SCALE_MIN = {
  MEDIUM = nil,
}
_G.TUNING.WINDBLOWN_SCALE_MAX = {
  MEDIUM = nil,
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
