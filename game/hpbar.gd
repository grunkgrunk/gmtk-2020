extends Label


func _process(delta):
	text = str(get_parent().value)+ " HP"
