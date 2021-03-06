extends Node2D
signal jump_around_done

var radius = 50
var count = 0
export(NodePath) var target
onready var tgt = get_node(target)
onready var cs = get_tree().get_nodes_in_group("Camera")


func _ready():
	$yes.connect("button_down", self, "_on_no_button_down")

func _on_no_button_down():
	if(len(cs)==1):
		cs[0].shake(2, 15, 12)
	if count > 100:
		#$tween.interpolate_property(self, "global_position", global_position, rndbox(), 0.2, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		#$tween.start()
		pass
		
	elif count < 8:
		var s = get_node("s" + str(2))
		s.pitch_scale = rand_range(0.9, 1.1)
		s.play()
		$tween.interpolate_method(self, "move_window", OS.window_position, rnd(), 0.2, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		$tween.start()
	else:
		emit_signal("jump_around_done")
	count+=1
func rnd():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var center = screen_size*0.5 - window_size*0.5 
	while true:
		var a = rand_range(0, 2*PI)
		var to = center + Vector2(cos(a), sin(a)) * 150
		if OS.window_position.distance_to(to) > 60:
			return to

func rndbox():
	var center = get_viewport().size * 0.5
	while true:
		var a = rand_range(0, 2*PI)
		var to = center + Vector2(cos(a), sin(a)) * 150
		if global_position.distance_to(to) > 60:
			return to
			
func move_window(to):
	OS.window_position = to
