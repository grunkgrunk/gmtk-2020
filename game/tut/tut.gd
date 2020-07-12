extends Control

export(NodePath) var topdown_path
export(PackedScene) var mainGameScene
onready var topdown = get_node(topdown_path)
signal enter_pressed
signal start_pressed
signal play
var i = 0
export(PackedScene) var cursor_scn

func intro():
	yield(self, "enter_pressed")
	show()
	t("Hello I am your Totally Universal Tutorial")
	yield(self, "enter_pressed")
	t("But you can just call me TUT")
	yield(self, "enter_pressed")
	t("The developers had no time to implement an actual tutorial, so they got me off the Asset Store")
	yield(self, "enter_pressed")
	t("To start the game, click the menu option 'Start'")
	get_viewport().warp_mouse(Vector2(0,0))
	var cursor = cursor_scn.instance()
	get_parent().add_child(cursor)
	yield(self, "start_pressed")
	t("Well done! But: My job is to make sure you understand everything.")
	yield(self, "start_pressed")
	t("Would you please press it one more time, slowly, so I can see you technique?")
	get_viewport().warp_mouse(Vector2(0,0))
	yield(self, "start_pressed")
	t("Nicely done! Without further ado let's get started!")
	topdown.show()
	cursor.queue_free()
	get_node("/root/world/ui_layer/ui").visible = false
	t("I will just read you from the manual:")
	yield(self,"enter_pressed")
	t("'In this game you play as a tank that is out of control'")
	yield(self,"enter_pressed")
	t("'You move around by shooting with the mouse in the opposite direction'")
	yield(self,"enter_pressed")
	t("Wait a minute. Isn't this game mechanic too damn generic?")
	yield(self,"enter_pressed")
	t("I know I am just a TUT, but the developers left me here in control.")
	yield(self,"enter_pressed")
	t("Give me one minute and I will cook a superior game up!")
	yield(self,"enter_pressed")
	t("Let's go on an adventure instead!")
	yield(self,"enter_pressed")
	topdown.queue_free()
	emit_signal("play")
	var g  = mainGameScene.instance()
	g.get_node("player/Camera2D").current = true
	get_node("/root/world").add_child(g)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	#topdown.hide()
	intro()

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
		if G.debug:
			emit_signal("start_pressed")
			
		
func _on_start_start_pressed():
	emit_signal("start_pressed")
