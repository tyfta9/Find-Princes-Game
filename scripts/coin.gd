extends Area2D

@onready var pickup_animation: AnimationPlayer = $PickupAnimation

func _on_body_entered(_body: Node2D) -> void:
	print("Coin collected!")
	pickup_animation.play("pickup")
