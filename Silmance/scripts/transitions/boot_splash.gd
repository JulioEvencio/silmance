extends Control

func _ready() -> void:
	Singleton.audio_menu_play()

func _to_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_timer_timeout() -> void:
	Transition.start(func(): _to_menu())
