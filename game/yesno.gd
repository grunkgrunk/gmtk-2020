extends Control

var radius = 50
export(NodePath) var target
onready var tgt = get_node(target)
func _ready():
	$dialog/no.connect("button_down", self, "_on_no_button_down")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_no_button_down():
	$tween.interpolate_method(self, "move_window", OS.window_position, rnd(), 0.2, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$tween.start()

func rnd():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var center = screen_size*0.5 - window_size*0.5 
	while true:
		var a = rand_range(0, 2*PI)
		var to = center + Vector2(cos(a), sin(a)) * 150
		if OS.window_position.distance_to(to) > 60:
			return to

func move_window(to):
	OS.window_position = to
