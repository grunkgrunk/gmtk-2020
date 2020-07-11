extends Area2D

export(NodePath) var dragon_scene
func _on_dragon_area_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		
