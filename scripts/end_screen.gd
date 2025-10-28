extends CanvasLayer

@export var game_over_label_text: String = "Game over"
@export var game_win_label_text: String = "You won!"
@export var score_label_text: String = "Your score: "
@export var time_label_text: String = "Your time: "
@export var top_time_label_text: String = "Your top time: "

@onready var _end_label: Label = %EndLabel
@onready var _score_label: Label = %ScoreLabel
@onready var _time_label: Label = %TimeLabel
@onready var _top_time_label: Label = %TopTimeLabel
@onready var _restart_button: Button = %RestartButton
@onready var _exit_button: Button = %ExitButton

const GAME: Resource = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_exit_button.button_up.connect(_exit_button_up)
	_restart_button.button_up.connect(_restart_button_up)
	_score_label.text = score_label_text
	_time_label.text = time_label_text
	_top_time_label.text = top_time_label_text

func _exit_button_up():
	get_tree().quit()

func _restart_button_up():
	print("restarting")
	get_tree().reload_current_scene()
	#Game.pause()

func _set_end_game_label(hp: int):
	if hp < 1:
		_end_label.text = game_over_label_text
	else:
		_end_label.text = game_win_label_text

func _set_score(score: int):
	_score_label.text += str(score)

func _set_time(time: float):
	_time_label.text += str(time).pad_decimals(2)

func _set_top_time(hp: int, time: float):
	var saver_loader: SaverLoader = SaverLoader.new()
	var top_time = saver_loader.load_top_time()
	print("Setting top time - " + str(top_time))
	
	#if hp > 0 && top_time > 0 && top_time < time:
		#_top_time_label.text += str(time).pad_decimals(2)
		#saver_loader.save_top_time(time)
	#else:
		#_top_time_label.text += str(top_time).pad_decimals(2)
	
	# if playr is NOT dead adn top time exist
	#if !hp > 0 && top_time < 0:
		#_top_time_label.text += str(top_time).pad_decimals(2)
		
	if top_time < 0 || top_time > time:
		if hp > 0:
			_top_time_label.text += str(time).pad_decimals(2)
			saver_loader.save_top_time(time)
		else:
			_top_time_label.text += "N/A"
	else:
		_top_time_label.text += str(top_time).pad_decimals(2)
	
	
	#if top_time < 0:
		#_top_time_label.text += "N/A"
		#saver_loader.save_top_time(time)
		#pass
	#else if:
		#_top_time_label.text += str(top_time).pad_decimals(2)
		#saver_loader.save_top_time(top_time)
		#pass

func start(hp: int, score: int, time: float):
	_set_end_game_label(hp)
	_set_score(score)
	_set_time(time)
	_set_top_time(hp, time)
	var nodes: Array[Node] = get_tree().get_nodes_in_group("game_menu")
	for node in nodes:
		if node.has_method("on_game_menu"):
			node.call_deferred("on_game_menu")
	#Game.pause()
