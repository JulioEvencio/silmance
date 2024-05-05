extends Control

func _ready() -> void:
	visible = false

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed("escape"):
		get_tree().paused = not get_tree().paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if get_tree().paused else Input.MOUSE_MODE_CAPTURED)
		visible = get_tree().paused

func _resume() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false

func _main_menu() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _quit() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	call_deferred("_resume")

func _on_main_menu_pressed() -> void:
	Transition.start(func(): _main_menu())

func _on_quit_pressed() -> void:
	call_deferred("_quit")
