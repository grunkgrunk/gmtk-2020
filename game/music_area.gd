extends Area2D

signal musicdialogue

func _on_music_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("musicdialogue")
		queue_free() 
