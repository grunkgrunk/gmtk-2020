extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal almost_dead
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_took_damage():
	var cs = get_tree().get_nodes_in_group("Camera")
	if(len(cs)==1):
		cs[0].shake(0.2, 15, 10)
	value -= rand_range(3, 7)
	if value <= 0:
		value = 1
		emit_signal("almost_dead") 
		
