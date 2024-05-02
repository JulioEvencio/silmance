extends CharacterBody3D
class_name Player

@onready var _head : Node3D = get_node("Head")
@onready var _camera : Camera3D = get_node("Head/Camera3D")
@onready var _ray_cast : RayCast3D = get_node("Head/Camera3D/RayCast3D")

@onready var _hand : Node3D = get_node("Hand")
@onready var _flash_light : SpotLight3D = get_node("Hand/FlashLight")

var _head_y_axis : float = 0.0
var _camera_x_axis : float = 0.0
var _camera_sensitivity : float = Save.data.camera_sensitivity / 100
const _camera_acceleration : float = 5.0

var _player_speed : float = 8.0
var _player_acceleration : float = 5.0

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		_camera_motion(event)
	elif event is InputEventKey:
		if Input.is_action_just_pressed("toggle_flash_light"):
			_toggle_flash_light()
		if Input.is_action_just_pressed("interact") and _ray_cast.is_colliding():
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

func _toggle_flash_light() -> void:
	_flash_light.visible = false if _flash_light.visible else true

func _call_princess() -> void:
	_ray_cast.get_collider().to_follow()

func _camera_motion_sleep(delta : float) -> void:
	_head.rotation.y = lerp(_head.rotation.y, -deg_to_rad(_head_y_axis), _camera_acceleration * delta)
	_camera.rotation.x = lerp(_camera.rotation.x, -deg_to_rad(_camera_x_axis), _camera_acceleration * delta)

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
	
	velocity = velocity.lerp(direction * _player_speed + velocity.y * Vector3.UP, _player_acceleration * delta)
