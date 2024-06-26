extends Control

func _ready() -> void:
	Singleton.audio_menu_play()

func _start() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/lore.tscn")

func _settings() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/settings.tscn")

func _credits() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/credits.tscn")

func _quit() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	Transition.start(func(): _start())

func _on_settings_pressed() -> void:
	Transition.start(func(): _settings())

func _on_credits_pressed() -> void:
	Transition.start(func(): _credits())

func _on_quit_pressed() -> void:
	call_deferred("_quit")
