extends AnimatedSprite

var angle = 0
var speed = 400
func _process(delta):
	position += Vector2(cos(angle), sin(angle)) * speed * delta
	rotation = angle


func _on_Area2D_body_entered(body):
	queue_free()
	
