extends Control

@onready var close_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/ExitSettingsButton
@onready var sfx_slider: HSlider = $"MarginContainer/HBoxContainer/VBoxContainer/SFX slider"
@onready var music_slider: HSlider = $"MarginContainer/HBoxContainer/VBoxContainer/Music slider"
@onready var sfx_bus_index: int = AudioServer.get_bus_index("SFX")
@onready var music_bus_index: int = AudioServer.get_bus_index("Music")
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/ExitGameButton
@onready var touch_controls: Control = %TouchControls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	sfx_slider.set_value_no_signal(AudioServer.get_bus_volume_linear(sfx_bus_index))
	music_slider.set_value_no_signal(AudioServer.get_bus_volume_linear(music_bus_index))
	close_button.button_up.connect(close_button_up)
	exit_button.button_up.connect(exit_button_up)
	sfx_slider.drag_ended.connect(sfx_slider_draged)
	music_slider.drag_ended.connect(music_slider_draged)

func sfx_slider_draged(value_changed: bool):
	if !value_changed:
		return
	AudioServer.set_bus_volume_linear(sfx_bus_index, sfx_slider.value)
	print("sfx changed")

func music_slider_draged(value_changed: bool):
	if !value_changed:
		return
	AudioServer.set_bus_volume_linear(music_bus_index, music_slider.value)
	print("music changed")
	
func close_button_up():
	print("exit")
	self.hide()
	touch_controls.show()
	Game.pause()

func exit_button_up():
	get_tree().quit()
