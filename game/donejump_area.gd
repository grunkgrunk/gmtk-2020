extends Area2D

signal donejump


func _on_donejump_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("donejump")
		queue_free() 
