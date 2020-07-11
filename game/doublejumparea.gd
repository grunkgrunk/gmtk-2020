extends Area2D

signal doublejump

func _on_doublejumparea_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("doublejump")
		queue_free() 
