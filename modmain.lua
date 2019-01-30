local _G = GLOBAL
local require = _G.require

local DEBUG = false

Assets =
{
}

PrefabFiles =
{
  "smelter",
  "alloy",
  "iron",
}

require("modstrings")
require("modrecipes")

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

local ACTIONS = _G.ACTIONS
local old_harvest_fn = ACTIONS.HARVEST.fn
ACTIONS.HARVEST.fn = function(act)
  if act.target.components.melter ~= nil then
    return act.target.components.melter:Harvest(act.doer)
  end
  return old_harvest_fn(act)
end

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
      giveitem("iron")
      giveitem("iron")
      giveitem("iron")
      giveitem("alloy")
    end
  end)
end
