extends Node

@onready var _princess : Princess = get_node("Node3D/Entities/Princess")

var _princess_can_spawn : bool = true

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

func _spawn_princess(x : float, z : float) -> void:
	if _princess_can_spawn:
		_princess.position.x = x
		_princess.position.z = z
		_princess_can_spawn = false

func _on_spwan_right_body_entered(_body : Player) -> void:
	_spawn_princess(-19.0, -4.5)

func _on_spawn_left_body_entered(_body : Player) -> void:
	_spawn_princess(16.0, -34.5)
