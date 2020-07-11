extends Node2D

export(bool) var paused = false

var pos = Vector2()
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
func _on_tut_play():
	$ui_layer/ui.hide()
	#$mainGame.show()

	
