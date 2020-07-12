extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxlook = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var c = get_tree().get_nodes_in_group("cursor")
	if randf() > 0.99:
		$tween.interpolate_property(self,"scale",Vector2(1,1),Vector2(1,0),0.1)
		$tween.start()
		yield($tween,"tween_completed")
		$tween.interpolate_property(self,"scale",Vector2(1,0),Vector2(1,1),0.1)
		$tween.start()
	if len(c) > 0:
		var d = $tuteyeblack.global_position - c[0].global_position
		d = -d/d.length()
		$tuteyeblack.global_position = global_position + d*maxlook
