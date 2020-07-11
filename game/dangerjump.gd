extends Area2D

signal shouldsave

func _on_dangerjump_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("shoudlsave")
		queue_free() 
