extends Node

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
