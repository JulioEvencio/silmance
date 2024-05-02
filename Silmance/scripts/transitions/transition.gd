extends CanvasLayer

@onready var _animation_player : AnimationPlayer = get_node("AnimationPlayer")

var _lambda : Callable

func _ready() -> void:
	_animation_player.play("fade_out")

func start(callable : Callable) -> void:
	_lambda = callable
	_animation_player.play("fade_in")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"fade_in":
			_lambda.call()
			_animation_player.play("fade_out")
