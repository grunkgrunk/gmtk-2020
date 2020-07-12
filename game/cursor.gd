extends Node2D

signal win
onready var lastpos = get_viewport().get_mouse_position()
# Called when the node enters the scene tree for the first time.
func _ready():
	#$pop.play()
	position = get_viewport().get_mouse_position()
	get_viewport().warp_mouse(get_viewport().size * 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()

func left():
	pass

func _input(event):
	if event.is_action_pressed("left_click"):
		$click.play()
		for a in $Area2D.get_overlapping_areas():
			if a.is_in_group("eye"):
				emit_signal("win")

func _on_cursor_visibility_changed():
	if visible:
		$pop.play()
		
