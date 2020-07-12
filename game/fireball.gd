extends Node2D

signal took_damage

var angle = 0
var speed = 600
var paused = false
var dead = false


func _ready():
	$fire.pitch_scale = rand_range(0.9, 1.1) 
	$fire.play()

func pause():
	paused = true
func resume():
	paused = false

func _process(delta):
	if dead:
		return
	if paused:
		return
	position += Vector2(cos(angle), sin(angle)) * speed * delta
	rotation = angle

func _on_Area2D_body_entered(body):
	$hit.pitch_scale = rand_range(0.99, 1.02)
	$hit.play()
	
	hide()
	if body.is_in_group("player"):
		var i = str(randi() % 4 +1)
		get_node("hit_player_" + str(i)).play()
	





func _on_hit_finished():
	queue_free()


func _on_Timer_timeout():
	$one.visible = !$one.visible
	$two.visible = !$two.visible
