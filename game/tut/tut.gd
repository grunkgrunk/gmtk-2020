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
	t("Hello I will be you Personalized Object Tutorial")
	yield(self, "enter_pressed")
	t("You can call me P.O.T.")
	yield(self, "enter_pressed")
	t("To start the game, click the menu option 'Start'")
	get_viewport().warp_mouse(Vector2(0,0))
	var cursor = cursor_scn.instance()
	get_parent().add_child(cursor)
	yield(self, "start_pressed")
	t("Good job! Now, just do it one more time")
	get_viewport().warp_mouse(Vector2(0,0))
	yield(self, "start_pressed")
	t("Nicely done! Without further ado let's get started!")
	topdown.show()
	cursor.queue_free()
	get_node("/root/world/ui_layer/ui").visible = false
	t("'In the game you move around by shooting' (Press enter to continue tutorial)")
	yield(self,"enter_pressed")
	t("'You have to clear 100 random levels of rising difficulty'")
	yield(self,"enter_pressed")
	t("Wait a minute. This sounds too damn generic.")
	yield(self,"enter_pressed")
	t("I know I am a tutorial-robot, but I can barely say this with a straight face")
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
