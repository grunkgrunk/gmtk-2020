extends Area2D


signal breakdialogue

func _on_break_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("breakdialogue")
		queue_free() 


func _on_turnoffmusic_area_body_entered(body):
	queue_free()
