extends AnimatedSprite

var is_mouth_open = false
var n_fireballs = 13
export(PackedScene) var fireball_scene
var paused = false

func pause():
	if paused:
		return
	paused = true
	$animation.queue_free()
func resume():
	paused = false
	$animation.play()

func fire_balls():
	if paused:
		return
	$shoot_timer.start()

func _on_shoot_timer_timeout():
	if paused:
		return
	var o = fireball_scene.instance()
	get_parent().add_child(o)
	o.global_position = $pos.global_position
	o.angle = rotation + PI - 0.3
	n_fireballs -= 1
	if n_fireballs == 0:
		$shoot_timer.stop()
		n_fireballs = 13

func _on_animation_animation_finished(anim_name):
	if paused:
		return
	if anim_name == "intro":
		$animation.play("idle")
		$idle_timer.wait_time = rand_range(2, 3)
		$idle_timer.start()
		$music.play()
	if anim_name == "fire":
		$idle_timer.wait_time = rand_range(2, 3)
		$idle_timer.start()
		$animation.play("idle")

func _on_idle_timer_timeout():
	if paused:
		return
	$animation.play("fire")
	
func shake():
	var cs = get_tree().get_nodes_in_group("Camera")
	if(len(cs)==1):
		cs[0].shake(1, 15, 12)
	

