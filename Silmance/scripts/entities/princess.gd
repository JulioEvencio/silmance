extends CharacterBody3D
class_name Princess

@export var player : Player

@onready var _animation_player : AnimationPlayer = get_node("Girl/AnimationPlayer")
@onready var _navigation_agent_3D : NavigationAgent3D = get_node("NavigationAgent3D")

const _SPEED = 1.5

var _can_run : bool = false
var _can_follow_player : bool = false
var _last_position : Vector3 = Vector3.ZERO
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	
	if _can_follow_player and _can_run and _last_position != global_position:
		_animation_player.play("walk")
		
		_to_move()
		_look_at_player(delta)
	else:
		_animation_player.play("idle")
	
	move_and_slide()

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _to_move() -> void:
	_last_position = global_position
	_navigation_agent_3D.target_position = player.global_position
	
	var direction : Vector3 = (_navigation_agent_3D.get_next_path_position() - global_position).normalized()
	
	if direction:
		velocity.x = direction.x * _SPEED
		velocity.z = direction.z * _SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)
		velocity.z = move_toward(velocity.z, 0, _SPEED)

func to_follow_player() -> void:
	_can_follow_player = true

func _look_at_player(delta : float) -> void:
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), delta * 7)

func _on_area_3d_body_entered(_body : Player) -> void:
	_last_position = player.global_position
	_can_run = false
	
	velocity.x = move_toward(velocity.x, 0, _SPEED)
	velocity.z = move_toward(velocity.z, 0, _SPEED)

func _on_area_3d_body_exited(_body : Player) -> void:
	_can_run = true
