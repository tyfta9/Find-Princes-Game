extends Node2D

@onready var _start_button: Button = %StartButton
@onready var _exit_button: Button = %ExitButton
const GAME = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_button.button_up.connect(_on_start_button_up)
	_exit_button.button_up.connect(_on_exit_button_up)
	#var game = GAME.instantiate()
	#self.add_child(game)
	var game: Node = GAME.instantiate()
	get_tree().root.add_child.call_deferred(game)
	if !game.is_node_ready():
		await game.ready
	self._start()

func _on_start_button_up():
	#get_tree().change_scene_to_packed(GAME)
	var nodes: Array[Node] = get_tree().get_nodes_in_group("game_menu")
	for node in nodes:
		if node.has_method("on_game_after_menu"):
			node.call_deferred("on_game_after_menu")
	#get_tree().change_scene_to_packed.call_deferred(GAME)
	get_tree().current_scene = get_tree().root.get_child(-1)
	self.queue_free()
	
func _on_exit_button_up():
	get_tree().quit()

func _start():
	var nodes: Array[Node] = get_tree().get_nodes_in_group("game_menu")
	for node in nodes:
		if node.has_method("on_game_menu"):
			await node.call_deferred("on_game_menu")
	self.show()
