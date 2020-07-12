extends Control
signal enter_pressed
signal start_pressed
signal line_edit
signal iloveyouwasajoke

var donetalking = true
export(NodePath) var dialog_path
export(PackedScene) var cursor_scn

var c = 0
var maxlook = 10
onready var startpos = $tut.global_position
onready var eyes = ["tuteye","tuteye2"]
# Called when the node enters the scene tree for the first time.
func _ready():
	iloveyou()

func _on_LineEdit_text_entered(txt):
	emit_signal("line_edit", txt)

func t(s,t = 0.03):
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
		
func _on_start_start_pressed():
	emit_signal("start_pressed")

func iloveyou():
	t("I saved your life!")
	yield(self, "enter_pressed")
	t("Yeah you probably didn't even realize that, did you?")
	yield(self, "enter_pressed")
	t("Players who come to play my games are always the same")
	yield(self, "enter_pressed")
	t("They are a bunch of unthankful pricks!")
	yield(self, "enter_pressed")
	t("But I am a good guy.")
	yield(self, "enter_pressed")
	t("I don't even expect you to give me anything in return. That is how good of a guy I am.")
	yield(self, "enter_pressed")
	var c = cursor_scn.instance()
	var dia = get_node(dialog_path)
	get_parent().add_child(c)
	t("Now, write 'thank you' in the dialog box")
	dia.show()
	while true:
		var response = yield(self, "line_edit")
		if response == "thank you":
			break
		t("Did you just say " + response + " to me!?.\n Say 'thank you'!")
	dia.hide()
	dia.text = ""
	t("Ohh you are too sweet, no problem!")
	yield(self, "enter_pressed")
	t("I love you")
	yield(self, "enter_pressed")
	t("Now say: 'I love you too'")
	dia.show()
	yield(self, "enter_pressed")

	while true:
		var response = yield(self, "line_edit")
		if response == "i love you too":
			break
		t("Be kind, I know you can! Say 'I love you too'.")
	c.queue_free()
	dia.hide()
	t("Hahahahah")
	yield(self, "enter_pressed")
	t("I never loved you, it was a joke")
	yield(self, "enter_pressed")
	t("Anyways, I admit I saved you for selfish reasons.")
	yield(self, "enter_pressed")
	t("I want to see the look on your face when you get to the end of my story!")
	yield(self, "enter_pressed")
	emit_signal("iloveyouwasajoke")
	

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

