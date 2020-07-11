extends Area2D

signal first_jump

func _on_jump_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("first_jump")
		queue_free()
