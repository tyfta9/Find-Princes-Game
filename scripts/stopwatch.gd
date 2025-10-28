class_name Stopwatch

extends Control

@onready var _time_label: Label = %TimeLabel
@onready var _top_time_label: Label = %TopTimeLabel
@export var top_time_label_text: String = "Top Time: "
@export var time_label_text: String = "Time: "
@export var paused: bool = false

var _top_time: float
var _time: float

func _process(delta: float) -> void:
	if !paused:
		_time += delta
		_time_label.text = time_label_text + str(_time).pad_decimals(2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SaverLoader.new().delete_save()
	#
	_time_label.text = time_label_text
	_top_time_label.text = top_time_label_text
	var saver_loader: SaverLoader = SaverLoader.new()
	var top_time: float = saver_loader.load_top_time()
	if !top_time < 0:
		_top_time_label.text += str(top_time).pad_decimals(2)
	else:
		_top_time_label.text += "N/A"
	self.start()

func _set_top_time():
	_top_time = _time
	var saver_loader: SaverLoader = SaverLoader.new()
	var previus_top_time: float = saver_loader.load_top_time()
	#if previus_top_time < 0 || previus_top_time > _top_time:
		#saver_loader.save_top_time(_top_time)

func get_top_time() -> float:
	return _top_time
	
func on_load(save: Resource):
	print("Top Time loaded save")

func start():
	_time = 0.0
	paused = false

func pause() -> bool:
	paused = !paused
	return paused

func stop():
	paused = true
	_set_top_time()
	
func get_time() -> float:
	return _time
