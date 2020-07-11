extends Node2D



func _on_tut_play():
	
	$player.playing = true
	$player/Camera2D.current = true
