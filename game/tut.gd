extends Control

signal enter_pressed
signal start_pressed
signal play
var i = 0
export(PackedScene) var cursor_scn


func intro():
	yield(self, "enter_pressed")
	t("Hello I will be you Personalized Object Tutorial")
	yield(self, "enter_pressed")
	t("You can call me P.O.T.")
	yield(self, "enter_pressed")
	t("To start the game, click the menu option 'Start'")
	get_viewport().warp_mouse(Vector2(0,0))
	get_parent().add_child(cursor_scn.instance())
	yield(self, "start_pressed")
	t("Good job! Now, just do it one more time")
	get_viewport().warp_mouse(Vector2(0,0))
	yield(self, "start_pressed")
	t("Nicely done! Without further ado let's get started!")
	get_node("/root/world/topdown").visible = true
	get_node("/root/world/ui").visible = false
	t("'In the game you move around by shooting'")
	yield(self,"enter_pressed")
	t("'You have to clear 100 random levels of rising difficulty'")
	yield(self,"enter_pressed")
	t("Wait a minute. This sounds too damn generic.")
	yield(self,"enter_pressed")
	t("I know I am a tutorial-robot, but I can barely say this with a straight face")
	yield(self,"enter_pressed")
	t("Let's go on an adventure instead!")
	yield(self,"enter_pressed")
	get_node("/root/world/topdown").visible = false
	emit_signal("play")
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	intro()

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
		
func _on_start_start_pressed():
	emit_signal("start_pressed")
