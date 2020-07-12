extends Node2D

func _ready():
	#hide()
	#$player.playing = false
	pass
func play():
	$player.playing = true
	$player.anim_player.stop(false)

func pause():
	$player.playing = false
	$player.anim_player.play()

