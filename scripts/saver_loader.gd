extends Node
class_name SaverLoader

@export var save_file_path: String = "user://save_game.data"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_top_time(time: float):
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(time)
	print("Data saved from SaverLoader! - " + str(time))
	file.close()

func load_top_time() -> float:
	if !FileAccess.file_exists(save_file_path):
		return -1
	var file: FileAccess = FileAccess.open(save_file_path, FileAccess.READ)
	var time: float = file.get_var()
	print("Datat loaded from SaverLoader! - " + str(time))
	file.close()
	return time

func delete_save():
	if !FileAccess.file_exists(save_file_path):
		return
	OS.move_to_trash(ProjectSettings.globalize_path(save_file_path))
	print("Save deleted from SaverLoader")
