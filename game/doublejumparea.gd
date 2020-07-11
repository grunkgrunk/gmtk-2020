extends Area2D

signal doublejump
var used = false

func _on_doublejumparea_body_entered(body):
	if body.is_in_group("player") and not used:
		emit_signal("doublejump")
		used = true
