extends CharacterBody3D
class_name Silmance

signal gamer_over

@export var _path_follow_3d : PathFollow3D

@onready var _ray_cast_3d : RayCast3D = get_node("RayCast3D")

const _SPEED : float = 1.0

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	_move(delta)
	_alert_player()
	move_and_slide()

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _move(delta : float) -> void:
	_path_follow_3d.progress += _SPEED * delta

func _alert_player() -> void:
	if _ray_cast_3d.is_colliding():
		gamer_over.emit()
