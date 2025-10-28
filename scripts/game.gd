extends Node2D

@onready var master_bus_index: int = AudioServer.get_bus_index("Master")

func _ready() -> void:
	# unmute game if muted
	if !OS.is_debug_build():
		AudioServer.set_bus_mute(master_bus_index, false)
	
func save_game():
	print("Game Saved!")

func load_game():
	print("Game Loaded!")

func pause():
	get_tree().paused = !get_tree().paused
