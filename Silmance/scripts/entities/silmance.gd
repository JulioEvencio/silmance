extends CharacterBody3D
class_name Silmance

signal gamer_over

@export var _path_follow_3d : PathFollow3D

@onready var _ray_cast_3d_center : RayCast3D = get_node("RayCast3DCenter")
@onready var _ray_cast_3d_right : RayCast3D = get_node("RayCast3DRight")
@onready var _ray_cast_3d_left : RayCast3D = get_node("RayCast3DLeft")
@onready var _animation_player : AnimationPlayer = get_node("Silmance/AnimationPlayer")

const _SPEED : float = 1.0

var _can_move : bool = true
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	
	if _can_move:
		_move(delta)
		_alert_player()
	
	move_and_slide()

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _move(delta : float) -> void:
	_path_follow_3d.progress += _SPEED * delta

func _alert_player_emit(player : Player) -> void:
	look_at(player.global_position, Vector3.UP, false)
	_can_move = false
	_animation_player.play("idle")
	player.set_physics_process(false)
	player.camera.look_at(global_position, Vector3.UP, false)
	gamer_over.emit()

func _alert_player() -> void:
	if _ray_cast_3d_center.is_colliding() and _ray_cast_3d_center.get_collider() is Player:
		_alert_player_emit(_ray_cast_3d_center.get_collider())
	elif _ray_cast_3d_right.is_colliding() and _ray_cast_3d_right.get_collider() is Player:
		_alert_player_emit(_ray_cast_3d_right.get_collider())
	elif _ray_cast_3d_left.is_colliding() and _ray_cast_3d_left.get_collider() is Player:
		_alert_player_emit(_ray_cast_3d_left.get_collider())
