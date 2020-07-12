extends Control
signal enter_pressed
signal start_pressed
signal line_edit
signal iloveyouwasajoke

export(NodePath) var dialog_path
export(PackedScene) var cursor_scn

# Called when the node enters the scene tree for the first time.
func _ready():
	iloveyou()

func _on_LineEdit_text_entered(txt):
	emit_signal("line_edit", txt)

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
		
func _on_start_start_pressed():
	emit_signal("start_pressed")

func iloveyou():
	t("I saved your life.")
	yield(self, "enter_pressed")
	t("Yeah you probably didn't even realize that did you?")
	yield(self, "enter_pressed")
	t("Players who come to play this game are always the same")
	yield(self, "enter_pressed")
	t("There are just a bunch of unthankful pricks")
	yield(self, "enter_pressed")
	t("But I am a good guy.")
	yield(self, "enter_pressed")
	t("I don't even expect you to give me anything in return that is how good of a guy I am.")
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
		t("Did you just call me" + response + "?. Say 'thank you'")
	dia.hide()
	dia.text = ""
	t("Ohh you are too sweet, no problem!")
	yield(self, "enter_pressed")
	t("I love you")
	yield(self, "enter_pressed")
	t("Now say: 'i love you too'")
	dia.show()
	yield(self, "enter_pressed")

	while true:
		var response = yield(self, "line_edit")
		if response == "i love you too":
			break
		t("Be kind, I know you can! Say 'i love you too'.")
	c.queue_free()
	dia.hide()
	t("Hahahahah")
	yield(self, "enter_pressed")
	t("I never loved you, it was a joke")
	yield(self, "enter_pressed")
	t("Anyways, the only reason I saved you is because I don't want to teach everything about the game again.")
	emit_signal("iloveyouwasajoke")

	
