extends Node

@onready var player : Player = get_node("Player")

func _ready() -> void:
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _process(_delta : float) -> void:
	if player.position.y < -100:
		get_tree().reload_current_scene()
