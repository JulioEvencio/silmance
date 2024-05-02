extends Control

func _to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_button_pressed() -> void:
	Transition.start(func(): _to_main_menu())
