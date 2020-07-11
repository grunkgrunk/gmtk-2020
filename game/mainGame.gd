extends Node2D

func _ready():
	#hide()
	#$player.playing = false
	pass
func _on_tut_play():
	$player.playing = true

func _on_tut_pause():
	$player.playing = false

func _on_jump_area_first_jump():
	_on_tut_pause()
