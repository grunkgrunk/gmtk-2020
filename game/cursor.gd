extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var lastpos = get_viewport().get_mouse_position()
# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = get_viewport().get_mouse_position()

func left():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		left()
