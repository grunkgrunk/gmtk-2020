extends Control

export(NodePath) var topdown_path
export(PackedScene) var mainGameScene
onready var topdown = get_node(topdown_path)
signal enter_pressed
signal start_pressed
signal play
var i = 0
export(PackedScene) var cursor_scn
onready var startpos = $tut.position
var c = 0
var maxlook = 15
onready var eyes = ["tuteye","tuteye2"]
var donetalking = true


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

func t(s,t = 0.05):
	donetalking = false
	$Text.visible_characters = 0
	$Text.text = s
	for i in range(len(s)):
		if(randf()>0.3):
			$talk.pitch_scale = rand_range(0.8,1.2)
			$talk.play()
		$timer.start(t)
		$Text.visible_characters += 1
		yield($timer,"timeout")
	$talk.stop()
	donetalking = true


func _input(event):
	if(event.is_action_pressed("continue") and donetalking):
		emit_signal("enter_pressed")
		if G.debug:
			emit_signal("start_pressed")
			
		
func _on_start_start_pressed():
	emit_signal("start_pressed")


func _process(delta):
	c += delta
	$tut.position = startpos + Vector2(0,sin(c*2)*3)
	
	var c = get_tree().get_nodes_in_group("cursor")
	var r = randf() > 0.993
	for estr in eyes:
		var e = get_node(estr)
		var tween = e.get_node("tween")
		if r:
			tween.interpolate_property(e,"scale",Vector2(1,1),Vector2(1,0),0.1)
			tween.start()
			yield(tween,"tween_completed")
			tween.interpolate_property(e,"scale",Vector2(1,0),Vector2(1,1),0.1)
			tween.start()
		if len(c) > 0:
			var d = e.get_node("tuteyeblack").global_position - c[0].global_position
			d = -d/d.length()
			e.get_node("tuteyeblack").global_position = e.global_position + d*maxlook
	
