local imageAtlas = "images/iron.xml"
local assets =
{
  Asset("ANIM", "anim/iron_ore.zip"),
  Asset("ATLAS", imageAtlas),
  Asset("INV_IMAGE", "iron"),
}

--[[
local function onsave(inst, data)
  data.anim = inst.animname
end

local function onload(inst, data)
  if data and data.anim then
    inst.animname = data.anim
    inst.AnimState:PlayAnimation(inst.animname)
  end
end
--]]

local function fn(Sim)
  local inst = CreateEntity()

  inst.entity:AddTransform()
  inst.entity:AddAnimState()
  inst.entity:AddSoundEmitter()
  inst.entity:AddNetwork()

  MakeInventoryPhysics(inst)
  --MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)

  inst.AnimState:SetBank("iron_ore")
  inst.AnimState:SetBuild("iron_ore")
  inst.AnimState:PlayAnimation("idle")

  inst:AddTag("molebait")
  inst:AddTag("renewable")
  inst:AddTag("quakedebris")

    inst:AddTag("_iron")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    inst:RemoveTag("_iron")

  inst:AddComponent("edible")
  inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
  inst.components.edible.hungervalue = 1
  inst:AddComponent("tradable")

  inst:AddComponent("stackable")
  inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

  inst:AddComponent("inspectable")

  inst:AddComponent("inventoryitem")
  inst.components.inventoryitem.atlasname = imageAtlas

  inst:AddComponent("bait")

  --[[
  inst:AddComponent("repairer")
  inst.components.repairer.repairmaterial = "orp"
  inst.components.repairer.healthrepairvalue = TUNING.REPAIR_ROCKS_HEALTH

  inst.OnSave = onsave
  inst.OnLoad = onload
  --]]

  return inst
end

return Prefab("iron", fn, assets)
