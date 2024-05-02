extends Control

@onready var _language_option : OptionButton = get_node("VBoxContainer/Language/OptionButton")

@onready var _camera_label : Label = get_node("VBoxContainer/Camera/Value")
@onready var _camera_slider : Slider = get_node("VBoxContainer/Camera/CameraSlider")

@onready var _volume_label : Label = get_node("VBoxContainer/Volume/Value")
@onready var _volume_slider : Slider = get_node("VBoxContainer/Volume/VolumeSlider")

func _ready() -> void:
	_language_option.selected = 0
	
	_camera_slider.value = 50
	_show_value(_camera_label, int(_camera_slider.value))
	
	_volume_slider.value = 50
	_show_value(_volume_label, int(_volume_slider.value))

func _show_value(label : Label, value : int) -> void:
	if value == 100:
		label.text = str(value) + "%"
	elif value > 9:
		label.text = "0" + str(value) + "%"
	else:
		label.text = "00" + str(value) + "%"

func _to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_camera_slider_value_changed(value : float) -> void:
	_show_value(_camera_label, int(value))

func _on_volume_slider_value_changed(value : float) -> void:
	_show_value(_volume_label, int(value))

func _on_save_pressed() -> void:
	Transition.start(func(): _to_main_menu())

func _on_cancel_pressed() -> void:
	Transition.start(func(): _to_main_menu())
