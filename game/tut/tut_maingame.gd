extends Control

signal enter_pressed

export(NodePath) var mainGamePath

onready var mainGame = get_node(mainGamePath)

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")

func _on_jump_area_first_jump():
	t("What, how can you jump now, I havent' taught you how to do that")
	mainGame.pause()
	yield(self, "enter_pressed")
	mainGame.play()


