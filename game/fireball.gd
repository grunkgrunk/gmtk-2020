extends AnimatedSprite

signal took_damage

var angle = 0
var speed = 400
var paused = false

func pause():
	paused = true
func resume():
	paused = false

func _process(delta):
	if paused:
		return
	position += Vector2(cos(angle), sin(angle)) * speed * delta
	rotation = angle

func _on_Area2D_body_entered(body):
	queue_free()
	
	
