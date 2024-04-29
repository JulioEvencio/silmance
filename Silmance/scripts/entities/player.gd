extends CharacterBody3D
class_name Player

@onready var _head : Node3D = get_node("Head")
@onready var _camera : Camera3D = get_node("Head/Camera3D")

@onready var _hand : Node3D = get_node("Hand")
@onready var _flash_light : SpotLight3D = get_node("Hand/FlashLight")

var _head_y_axis : float = 0.0
var _camera_x_axis : float = 0.0
var _camera_sensitivity : float = 0.25
var _camera_acceleration : float = 5.0

var _player_speed : float = 8.0
var _player_acceleration : float = 5.0
var _jump_force : float = 8.0
var _gravity : float = 10.0

var _direction : Vector3 = Vector3.ZERO

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		_head_y_axis += event.relative.x * _camera_sensitivity
		_camera_x_axis += event.relative.y * _camera_sensitivity
		_camera_x_axis = clamp(_camera_x_axis, -90.0, 90.0)

func _process(delta : float) -> void:
	_direction = Input.get_axis("move_left", "move_right") * _head.basis.x + Input.get_axis("move_up", "move_down") * _head.basis.z
	velocity = velocity.lerp(_direction * _player_speed + velocity.y * Vector3.UP, _player_acceleration * delta)
	
	_head.rotation.y = lerp(_head.rotation.y, -deg_to_rad(_head_y_axis), _camera_acceleration * delta)
	_camera.rotation.x = lerp(_camera.rotation.x, -deg_to_rad(_camera_x_axis), _camera_acceleration * delta)
	
	_hand.rotation.y = -deg_to_rad(_head_y_axis)
	_flash_light.rotation.x = -deg_to_rad(_camera_x_axis)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += _jump_force
	else:
		velocity.y -= _gravity * delta
	
	move_and_slide()

#
#@onready var head : Node3D = get_node("Head")
#@onready var camera : Camera3D = get_node("Head/Camera3D")
#
#@onready var hand : Node3D = get_node("Hand")
#@onready var flash_light : Node3D = get_node("Hand/FlashLight")
#
#const SPEED : float = 5.0
#const JUMP_VELOCITY : float = 4.5
#
#var head_y_axis : float = 0.0
#var camera_x_axis : float = 0.0
#var camera_sensitivity : float = 0.25
#var camera_acceleration : float = 2.0
#
#var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
#
#func _process(delta : float) -> void:
	#head.rotation.y = lerp(head.rotation.y, -deg_to_rad(head_y_axis), camera_acceleration * delta)
	#camera.rotation.x = lerp(camera.rotation.x, -deg_to_rad(camera_x_axis), camera_acceleration * delta)
	#hand.rotation.y = -deg_to_rad(head_y_axis)
	#flash_light.rotation.x = -deg_to_rad(camera_x_axis)
#
#func _physics_process(delta : float) -> void:
	#_apply_gravity(delta)
	#_to_jump()
	#_to_move()
	#move_and_slide()
#
#func _input(event : InputEvent) -> void:
	#if event is InputEventMouseMotion:
		## rotate_y(-event.relative.x * 0.007)
		## camera.rotate_x(-event.relative.y * 0.008)
		## camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)
		#head_y_axis += event.relative.x * camera_sensitivity
		#camera_x_axis += event.relative.y * camera_sensitivity
#
#func _apply_gravity(delta : float) -> void:
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
#func _to_jump() -> void:
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
#func _to_move() -> void:
	#var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
