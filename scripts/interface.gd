class_name Interface

extends CanvasLayer

@onready var player_hp: PlayerHP = %PlayerHP as PlayerHP
@onready var score: Control = %Score as Score
@onready var stopwatch: Stopwatch = %Stopwatch as Stopwatch


func on_game_menu():
	print("Game ended form interface!")
	self.hide()

func on_game_after_menu():
	print("Game started from interface!")
	self.show()
