class_name Score

extends Control

@export var score_label_text: String = "Score:"
var coins: Array[Node] = []
var score: int = 0
@onready var score_label: Label = %ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.body_entered.connect(_on_body_entered)
	score_label.text = score_label_text
	pass # Replace with function body.

func _on_body_entered(_body: Node2D):
	score+=1
	score_label.text = score_label_text + str(score)

func get_score() -> int:
	return score
