local ModImagesAtlas = "images/modimages.xml"

Recipe(
  "smelter",
  {
    Ingredient("cutstone", 6),
    Ingredient("boards", 4),
    Ingredient("redgem", 1)
  },
  RECIPETABS.SCIENCE,
  TECH.SCIENCE_TWO,
  "smetler_placer"
).atlas = ModImagesAtlas
Recipe(
  "antmaskhat",
  {
    Ingredient("chitin", 5),
    Ingredient("footballhat", 1)
  },
  RECIPETABS.WAR,
  TECH.SCIENCE_ONE
)
Recipe(
  "antsuit",
  {
    Ingredient("chitin", 5),
    Ingredient("armorwood", 1)
  },
  RECIPETABS.WAR,
  TECH.SCIENCE_ONE
)
