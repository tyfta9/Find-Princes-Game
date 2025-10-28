extends Control

@onready var settings_button: TouchScreenButton = $SettingsButton
@onready var settings_menu: Control = %SettingsMenu
@onready var touch_controls: Control = %TouchControls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_button.released.connect(on_settings_button_up)
	pass

func _shortcut_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("settings"):
		print("esc pressed " + event.as_text())
		Game.pause()
		settings_menu.visible = !settings_menu.visible
		touch_controls.visible = !touch_controls.visible

func on_settings_button_up():
	Game.pause()
	settings_menu.show()
	touch_controls.hide()
