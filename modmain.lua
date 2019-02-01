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

--------------------------------------------------------------------
local ACTIONS = _G.ACTIONS

local old_cook_fn = ACTIONS.COOK.fn
ACTIONS.COOK.fn = function(act)
  if act.target.components.melter ~= nil then
    if act.target.components.melter:IsCooking() then
        --Already cooking
        return true
    end
    local container = act.target.components.container
    if container ~= nil and container:IsOpen() and not container:IsOpenedBy(act.doer) then
        return false, "INUSE"
    elseif not act.target.components.melter:CanCook() then
        return false
    end
    act.target.components.melter:StartCooking()
    return true
  end
  return old_cook_fn(act)
end

local old_harvest_fn = ACTIONS.HARVEST.fn
ACTIONS.HARVEST.fn = function(act)
  if act.target.components.melter ~= nil then
    return act.target.components.melter:Harvest(act.doer)
  end
  return old_harvest_fn(act)
end
--------------------------------------------------------------------
-- make `rock1`, `rock2` and `rock_moon` drop iron ore
local function change_rockdrop(drop_rate)
  return function(inst)
    if inst and inst.components.lootdropper then
      if drop_rate and 0 <= drop_rate and drop_rate <= 1 then
        local ld = inst.components.lootdropper
        ld:AddChanceLoot("iron", drop_rate)
      end
    end
  end
end

AddPrefabPostInit("rock1", change_rockdrop(0.25))
AddPrefabPostInit("rock2", change_rockdrop(0.5))
AddPrefabPostInit("rock_moon", change_rockdrop(1.0))
--------------------------------------------------------------------
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
