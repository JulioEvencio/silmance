extends CharacterBody3D
class_name Enemy

@export var path_follow_3d : PathFollow3D

const _SPEED : float = 3.0

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	_move(delta)
	move_and_slide()

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _move(delta : float) -> void:
	path_follow_3d.progress += _SPEED * delta
