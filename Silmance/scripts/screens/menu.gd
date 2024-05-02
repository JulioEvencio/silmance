extends Control

func _start() -> void:
	get_tree().change_scene_to_file("res://scenes/scenarios/scenario_test.tscn")

func _settings() -> void:
	pass

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
