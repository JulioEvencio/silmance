extends Node

@onready var _audio_menu : AudioStreamPlayer = get_node("AudioStreamPlayer")

func audio_menu_play() -> void:
	if not _audio_menu.playing:
		_audio_menu.play()

func audio_menu_stop() -> void:
	_audio_menu.stop()
