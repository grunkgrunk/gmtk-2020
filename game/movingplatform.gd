extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var d = 0

onready var startpos = position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	d+= delta
	position = startpos + Vector2(sin(d*10)*140,0)
