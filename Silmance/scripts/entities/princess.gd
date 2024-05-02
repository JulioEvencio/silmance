extends CharacterBody3D
class_name Princess

@export var player : Player

@onready var navigation_agent_3D : NavigationAgent3D = get_node("NavigationAgent3D")

const _SPEED = 5.0

var _can_run : bool = false
var _can_follow : bool = false

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	
	if _can_follow and _can_run:
		_to_move()
	
	move_and_slide()

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _to_move() -> void:
	navigation_agent_3D.target_position = player.global_position
	
	var direction : Vector3 = (navigation_agent_3D.get_next_path_position() - global_position).normalized()
	
	if direction:
		velocity.x = direction.x * _SPEED
		velocity.z = direction.z * _SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)
		velocity.z = move_toward(velocity.z, 0, _SPEED)

func to_follow() -> void:
	_can_follow = true

func _on_area_3d_body_entered(_body : Player) -> void:
	_can_run = false
	
	velocity.x = move_toward(velocity.x, 0, _SPEED)
	velocity.z = move_toward(velocity.z, 0, _SPEED)

func _on_area_3d_body_exited(_body : Player) -> void:
	_can_run = true
