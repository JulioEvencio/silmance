extends Control

func _start() -> void:
	get_tree().change_scene_to_file("res://scenes/scenarios/mansion.tscn")

func _on_button_pressed() -> void:
	Transition.start(func(): _start())
