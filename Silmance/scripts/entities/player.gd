extends CharacterBody3D
class_name Player

signal _can_interact_with_princess
signal _can_not_interact_with_princess

@onready var _head : Node3D = get_node("Head")
@onready var camera : Camera3D = get_node("Head/Camera3D")

@onready var _hand : Node3D = get_node("Hand")
@onready var _flash_light : SpotLight3D = get_node("Hand/FlashLight")

var _head_y_axis : float = 0.0
var _camera_x_axis : float = 0.0
var _camera_sensitivity : float = Save.data.camera_sensitivity / 100
const _camera_acceleration : float = 5.0

var _player_speed : float = 3.0
var _player_speed_base : float = 3.0
var _player_speed_run : float = 3.0
var _player_acceleration : float = 5.0

var _princess : Princess = null

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		_camera_motion(event)
	elif event is InputEventKey:
		if Input.is_action_just_pressed("interact") and _princess != null:
			_call_princess()

func _physics_process(delta : float) -> void:
	_camera_motion_sleep(delta)
	_flash_light_motion()
	_apply_gravity(delta)
	_move(delta)
	move_and_slide()

func _camera_motion(event : InputEventMouseMotion) -> void:
	_head_y_axis += event.relative.x * _camera_sensitivity
	_camera_x_axis += event.relative.y * _camera_sensitivity
	_camera_x_axis = clamp(_camera_x_axis, -90.0, 90.0)

func _call_princess() -> void:
	_princess.to_follow_player()

func _camera_motion_sleep(delta : float) -> void:
	_head.rotation.y = lerp(_head.rotation.y, -deg_to_rad(_head_y_axis), _camera_acceleration * delta)
	camera.rotation.x = lerp(camera.rotation.x, -deg_to_rad(_camera_x_axis), _camera_acceleration * delta)

func _flash_light_motion() -> void:
	_hand.rotation.y = -deg_to_rad(_head_y_axis)
	_flash_light.rotation.x = -deg_to_rad(_camera_x_axis)

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _move(delta : float) -> void:
	var direction_x : Vector3 = Input.get_axis("move_left", "move_right") * _head.basis.x
	var direction_z : Vector3 = Input.get_axis("move_up", "move_down") * _head.basis.z
	var direction : Vector3 = (direction_x + direction_z).normalized()
	
	if Input.is_action_pressed("run"):
		_player_speed = _player_speed_base + _player_speed_run
	else:
		_player_speed = _player_speed_base
	
	velocity = velocity.lerp(direction * _player_speed + velocity.y * Vector3.UP, _player_acceleration * delta)

func _on_area_3d_body_entered(body : Princess) -> void:
	_princess = body
	_can_interact_with_princess.emit()

func _on_area_3d_body_exited(_body : Princess) -> void:
	_princess = null
	_can_not_interact_with_princess.emit()
