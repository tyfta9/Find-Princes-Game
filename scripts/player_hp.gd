class_name PlayerHP

extends Control

var _hp: int
var _harts: Array[Node2D] = []
@export var _space: int = 5
@export var _hart_scale: Vector2 = Vector2(3,3)

@onready var _hart: Sprite2D = $Hart

func _ready() -> void:
	_hart.global_scale = _hart_scale
	pass

func get_demage():
	_hp -= 1
	if !(_hp<0):
		_harts[_hp].queue_free()
	else:
		push_error("Long time dead - PlayerHP func get_demage()!")

func set_max_hp(max_hp: int):
	_hp = max_hp
	_harts.resize(_hp)
	_harts[0] = _hart
	_set_harts()
	
func get_hp() -> int:
	return _hp
	
func _set_harts():
	for n in range(1, _hp):
		_harts[n] = _harts[n-1].duplicate()
		_harts[n].move_local_x(_hart.texture.get_width() * _hart_scale.x + _space)
		self.add_child(_harts[n])
	
