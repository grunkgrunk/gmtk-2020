extends Area2D

signal jumpfail


func _on_jumpfail_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("jumpfail")
		queue_free() 
