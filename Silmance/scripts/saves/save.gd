extends Node

const _path : String = "user://save_game.dat"

var data : Dictionary = {
	"default": true,
	"language": "en",
	"camera_sensitivity": 25.0,
	"volume": 50.0
}

func _ready() -> void:
	load_game()
	
	if Save.data.default:
		Save.data.language = TranslationServer.get_locale().substr(0, 2)
	
	TranslationServer.set_locale(Save.data.language)

func save_game() -> void:
	var file : FileAccess = FileAccess.open(_path, FileAccess.WRITE)
	
	if file != null:
		Save.data.default = false
		file.store_var(data)
		file.close()

func load_game() -> void:
	if FileAccess.file_exists(_path):
		var file : FileAccess = FileAccess.open(_path, FileAccess.READ)
		
		if file != null:
			data = file.get_var()
			file.close()
