extends Camera2D

# camera zoom on game end/start
@export var camera_zoom_on_game_menu: float = 8
@export var camera_zoom_on_game_start: float = 4
@export var camera_zoom_speed: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zoom = Vector2(camera_zoom_on_game_start, camera_zoom_on_game_start)

func zoom_in():
	print("Zoom in " + str(camera_zoom_on_game_menu)) 
	for n in range((camera_zoom_on_game_menu - zoom.x)*(camera_zoom_speed*100)):
		await get_tree().create_timer(0.001).timeout
		self.zoom += Vector2(camera_zoom_speed, camera_zoom_speed)

func zoom_out():
	print("Zoom out " + str(camera_zoom_on_game_start))
	for n in range((zoom.x - camera_zoom_on_game_start)*(camera_zoom_speed*100)):
		await get_tree().create_timer(0.001).timeout
		self.zoom -= Vector2(camera_zoom_speed, camera_zoom_speed)

func move_position_by(pos_addition: Vector2):
	var obj_pos: Vector2 = self.get_target_position()
	print(obj_pos)
	self.global_position += pos_addition
	#self.move_local_x(pos_addition.x)
	#self.move_local_y(pos_addition.y)
	print(self.global_position)
