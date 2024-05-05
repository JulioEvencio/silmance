extends Node

@onready var _interact_label : Label = get_node("HUD/InteractLabel")
@onready var _tutorial_label : Label = get_node("HUD/TutorialLabel")
@onready var _princess : Princess = get_node("Node3D/Entities/Princess")
@onready var _enemies_timer : Timer = get_node("Node3D/Entities/Enemies/EnemiesTimer")

var _princess_can_spawn : bool = true

func _ready() -> void:
	_interact_label.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		call_deferred("_quit")

func _quit() -> void:
	get_tree().quit()

func _victory() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/screens/victory.tscn")

func _game_over() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/screens/game_over.tscn")

func _spawn_princess(x : float, z : float) -> void:
	if _princess_can_spawn:
		_princess.position.x = x
		_princess.position.z = z
		_princess_can_spawn = false

func _on_spwan_right_body_entered(_body : Player) -> void:
	_spawn_princess(-19.0, -4.5)

func _on_spawn_left_body_entered(_body : Player) -> void:
	_spawn_princess(16.0, -34.5)

func _on_player__can_interact_with_princess() -> void:
	_interact_label.show()

func _on_player__can_not_interact_with_princess() -> void:
	_interact_label.hide()

func _on_tutorial_timer_timeout() -> void:
	_tutorial_label.hide()

func _on_victory_area_body_entered(_body : Princess) -> void:
	Transition.start(func(): _victory())

func _on_silmance_gamer_over() -> void:
	_enemies_timer.start()

func _on_enemies_timer_timeout() -> void:
	Transition.start(func(): _game_over())
