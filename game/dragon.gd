extends AnimatedSprite

var is_mouth_open = false
var n_fireballs = 13

export(PackedScene) var fireball_scene

func _ready():
	$animation.play("intro")


func fire_balls():
	$shoot_timer.start()

func _on_shoot_timer_timeout():
	var o = fireball_scene.instance()
	get_parent().add_child(o)
	o.global_position = $pos.global_position
	o.angle = rotation + PI - 0.3
	n_fireballs -= 1
	if n_fireballs == 0:
		$shoot_timer.stop()
		n_fireballs = 13

func _input(event):
	if(Input.is_action_just_pressed("continue")):
		$animation.play("fire")


func _on_animation_animation_finished(anim_name):
	if anim_name == "intro":
		$animation.play("idle")
		$idle_timer.wait_time = rand_range(2, 3)
		$idle_timer.start()
	if anim_name == "fire":
		$idle_timer.wait_time = rand_range(2, 3)
		$idle_timer.start()
		$animation.play("idle")

func _on_idle_timer_timeout():
	$animation.play("fire")
	
