extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("You get hurt! - from kill zone")
	if(body.is_inside_tree()):
		#body.get_tree().call_deferred("reload_current_scene")
		body.call_deferred("hurt")
	else:
		push_error("Body isn't inside tree")
