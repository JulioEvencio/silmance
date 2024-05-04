extends Node

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		call_deferred("_quit")

func _quit() -> void:
	get_tree().quit()

func _game_over() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_enemy_gamer_over():
	# Transition.start(func(): _game_over())
	pass
