extends Control

@onready var _language_option : OptionButton = get_node("VBoxContainer/Language/OptionButton")

@onready var _camera_label : Label = get_node("VBoxContainer/Camera/Value")
@onready var _camera_slider : Slider = get_node("VBoxContainer/Camera/CameraSlider")

@onready var _volume_label : Label = get_node("VBoxContainer/Volume/Value")
@onready var _volume_slider : Slider = get_node("VBoxContainer/Volume/VolumeSlider")

func _ready() -> void:
	match Save.data.language:
		"en":
			_language_option.selected = 0
		"pt":
			_language_option.selected = 1
		"es":
			_language_option.selected = 2
		_:
			_language_option.selected = 0
	
	_camera_slider.value = Save.data.camera_sensitivity
	_show_value(_camera_label, int(_camera_slider.value))
	
	_volume_slider.value = Save.data.volume
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

func _save() -> void:
	match _language_option.selected:
		0:
			Save.data.language = "en"
		1:
			Save.data.language = "pt"
		2:
			Save.data.language = "es"

	Save.data.camera_sensitivity = _camera_slider.value
	Save.data.volume = _volume_slider.value
	Save.save_game()
	
	TranslationServer.set_locale(Save.data.language)
	
	_to_main_menu()

func _cancel() -> void:
	_to_main_menu()

func _on_camera_slider_value_changed(value : float) -> void:
	_show_value(_camera_label, int(value))

func _on_volume_slider_value_changed(value : float) -> void:
	_show_value(_volume_label, int(value))

func _on_save_pressed() -> void:
	Transition.start(func(): _save())

func _on_cancel_pressed() -> void:
	Transition.start(func(): _cancel())
