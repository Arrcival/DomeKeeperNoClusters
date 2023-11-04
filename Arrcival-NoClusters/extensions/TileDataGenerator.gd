extends "res://content/map/generation/TileDataGenerator.gd"

func generate():
	.generate()
	
	if finishedSuccessful == false:
		return
	if not Level.loadout.modeConfig.get(CONST.MODE_CONFIG_RELICHUNT_WORLDMODIFIERS, "").has("worldmodifiernoclusters"):
		return
		
	finishedSuccessful = false
	var tdResources = $TileData / Resources
	var tdBiomes = $TileData / Biomes
		
	var ironCells = tdResources.get_used_cells_by_id(Data.TILE_IRON)
	var totalIron = ironCells.size()
		
	for c in ironCells:
		tdResources.set_cellv(c, Data.TILE_DIRT_START)
	
	var usedCells = tdResources.get_used_cells()
	var randomCells = Data.seedShuffle(usedCells, gen_seed)
	var placedIron = 0
	
	for cell in randomCells:
		if placedIron >= totalIron:
			break
		var ressourceCell = tdResources.get_cellv(cell)
		if ressourceCell >= Data.TILE_DIRT_START && ressourceCell <= Data.TILE_DIRT_END:
			tdResources.set_cellv(cell, Data.TILE_IRON)
			placedIron += 1
		
	finishedSuccessful = true

