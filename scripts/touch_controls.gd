extends Control

@onready var left_button_control: Control = %LeftButtonControl
@onready var right_button_control: Control = %RightButtonControl
@onready var jump_button_control: Control = %JumpButtonControl
@export var buttons_scale = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_button_control.scale = Vector2(buttons_scale, buttons_scale)
	right_button_control.scale = Vector2(buttons_scale, buttons_scale)
	jump_button_control.scale = Vector2(buttons_scale, buttons_scale)
	set_buttons_for_os()

func set_buttons_for_os():
	if OS.get_name() == "Windows":
		left_button_control.hide()
		right_button_control.hide()
		jump_button_control.hide()
