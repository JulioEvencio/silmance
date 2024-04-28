extends CharacterBody3D
class_name Player

@onready var camera : Camera3D = get_node("Camera3D")

const SPEED : float = 5.0
const JUMP_VELOCITY : float = 4.5

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta : float) -> void:
	_apply_gravity(delta)
	_to_jump()
	_to_move()
	move_and_slide()

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.007)
		camera.rotate_x(-event.relative.y * 0.008)
		# camera.rotation.x = clamp(camera.rotation.x, -PI/4, PI/4)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _apply_gravity(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

func _to_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _to_move() -> void:
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
