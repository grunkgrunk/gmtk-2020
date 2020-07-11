extends Node2D

export(bool) var paused = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos = Vector2()
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$mainGame.hide()

func _on_tut_play():
	$ui.hide()
	$mainGame.show()
