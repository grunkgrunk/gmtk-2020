extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var i = 0

var texts = ["Hello I will be you Personalized Object Tutorial","You can call me P.O.T.", "To start the game select the menu option 'Start' and press enter"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass #  with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func next():
	$Text.text = texts[i]
	i+=1

func _input(event):
	if(event.is_action_pressed("ui_accept")):
		next()
		
