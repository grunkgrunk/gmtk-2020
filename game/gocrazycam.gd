extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var crazy = false

var c = 0
# Called when the node enters the scene tree for the first time.
func gocrazy():
	crazy = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not crazy:
		return
	c += delta
	rotation = sin(c*10)/4
	zoom = Vector2(1+abs(sin(c*5))/4,1+abs(sin(c*5))/4)
