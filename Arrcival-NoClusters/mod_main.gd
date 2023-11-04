extends Node

const MYMODNAME_MOD_DIR = "Arrcival-NoClusters/"
const MYMODNAME_LOG = "Arrcival-NoClusters"

const EXTENSIONS_DIR = "extensions/"

func _init(modLoader = ModLoader):
	ModLoaderLog.info("init starting", MYMODNAME_LOG)
	var dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	var ext_dir = dir + EXTENSIONS_DIR
	
	# Add extensions
	loadExtension(ext_dir, "TileDataGenerator.gd")
	
	ModLoaderMod.add_translation(dir + "localization/arrcival-noclusters.en.translation")
	
	ModLoaderLog.info("init done", MYMODNAME_LOG)

func _ready():
	ModLoaderLog.info("_ready starting", MYMODNAME_LOG)
	add_to_group("mod_init")
	ModLoaderLog.info("_ready done", MYMODNAME_LOG)

func modInit():
	Data.registerRunModifier("noclusters")
	
	worldModifiersfix()
	print(Data.worldModifiers["worldmodifiernoclusters"].get("propertychanges",{}))
	
func worldModifiersfix():
	# Hardcoded it, no idea why it's not working
	Data.worldModifiers["worldmodifiernoclusters"] = {
		"type":"worldmodifier",
		"upgradelimits": ["noclusters"],
		}

func loadExtension(ext_dir, fileName):
	ModLoaderMod.install_script_extension(ext_dir + fileName)
