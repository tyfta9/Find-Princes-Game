extends Node2D

@onready var win_sound: AudioStreamPlayer2D = %WinSound
@onready var interface: Interface = %Interface as Interface

const END_MENU = preload("res://scenes/GUI/end_menu.tscn")
var _end_menu: CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_end_menu = END_MENU.instantiate()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("You Won from flower!")
	# check if we have the end menu
	if !_end_menu.is_inside_tree():
		add_child(_end_menu)
		interface.stopwatch.stop()
		_end_menu.start(interface.player_hp.get_hp(), interface.score.get_score(), interface.stopwatch.get_time())
	
