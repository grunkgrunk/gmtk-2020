extends Node2D

export(NodePath) var mainGamePath
export(NodePath) var healthPath
onready var mainGame = get_node(mainGamePath)

var dead = false
func _ready():
	hide()

func _on_dragon_area_body_entered(body):
	if body.is_in_group("player"):
		mainGame.pause()
		show()
		get_node(healthPath).show()
		$dragon/animation.play("intro")
		yield($dragon/animation, "animation_finished")
		mainGame.play()

func _process(delta):
	if not dead:
		return
	rotation -= delta 
	

func kill():
	dead = true
	$kill_tween.interpolate_property(self, "position", position, position+ Vector2(-200, 0), 2)
	$bowlersound.play()
	$kill_tween.start()
	$dragon/music.stop()
	yield($kill_tween,"tween_completed")
	queue_free()
	
	
func shake():
	var c = get_tree().get_node_in_group("camera")
	if len(c)==1:
		c[0].shake(5, 15, 20)
	
