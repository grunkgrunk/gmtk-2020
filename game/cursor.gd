extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal win
onready var lastpos = get_viewport().get_mouse_position()
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport().get_mouse_position()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = get_global_mouse_position()

func left():
	pass

func _input(event):
	if event.is_action_pressed("left_click"):
		print("yir")
		for a in $Area2D.get_overlapping_areas():
			if a.is_in_group("eye"):
				print("poked")
				emit_signal("win")
