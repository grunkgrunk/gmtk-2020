extends Node2D

export(NodePath) var mainGamePath
export(NodePath) var healthPath
onready var mainGame = get_node(mainGamePath)

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
