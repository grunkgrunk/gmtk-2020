extends Node2D

onready var startpos = $tut.position
var c = 0
var maxlook = 15
onready var eyes = ["tuteye","tuteye2"]

func _process(delta):
	c += delta
	$tut.position = startpos + Vector2(0,sin(c*2)*3)
	var c = get_tree().get_nodes_in_group("cursor")
	var p = get_tree().get_nodes_in_group("player")
	for estr in eyes:
		var e = get_node(estr)
		
		if len(c) > 0:
			var d = e.get_node("tuteyeblack").global_position - c[0].global_position
			d = -d/d.length()
			e.get_node("tuteyeblack").global_position = e.global_position + d*maxlook
		#elif len(p) > 0:
	#		var d = e.get_node("tuteyeblack").global_position - p[0].global_position
	#		d = -d/d.length()
	#		e.get_node("tuteyeblack").global_position = e.global_position + d*maxlook

func _on_Timer_timeout():
	var t = $tween
	for estr in eyes:
		var e = get_node(estr)
		t.interpolate_property(e,"scale",Vector2(1,1)*0.5,Vector2(1,0)*0.5,0.1)
	t.start()
	yield(t,"tween_completed")
	for estr in eyes:
		var e = get_node(estr)		
		t.interpolate_property(e,"scale",Vector2(1,0)*0.5,Vector2(1,1)*0.5,0.1)
	t.start()
	$Timer.wait_time = rand_range(2, 5)
