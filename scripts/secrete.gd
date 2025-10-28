extends Node2D

@onready var tocken: Area2D = $Tocken
@onready var animation_player: AnimationPlayer = $Tocken/AnimationPlayer

func _on_tocken_body_entered(body: Node2D) -> void:
	if(body.name.match("Player")):
		print("You've achived double jump!")
		body.call_deferred("set_double_jump", true)
		animation_player.play("pickup")
