extends Node2D

func _ready():
	#hide()
	#$player.playing = false
	pass
func play():
	$player.playing = true

func pause():
	$player.playing = false

