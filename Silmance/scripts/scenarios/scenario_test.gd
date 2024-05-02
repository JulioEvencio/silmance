extends Node

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		Transition.start(func(): _quit())

func _quit() -> void:
	get_tree().quit()

func _game_over() -> void:
	get_tree().reload_current_scene()

func _on_enemy_gamer_over():
	Transition.start(func(): _game_over())
