extends Control

signal enter_pressed
signal rebind_pressed
signal correct_key_bound
signal donebinding

export(NodePath) var gridPath
export(NodePath) var rebindPath
export(NodePath) var loadLabelPath
export(PackedScene) var cursorscn


onready var grid = get_node(gridPath)
var donetalking = true

var rebinding = false
var correct_keys = [
	{"curkey":"jump", "newkey": "W", "msg": "First press 'W' to bind 'W' to jump"}, 
	{"curkey":"left", "newkey": "D", "msg": "Now press a key to go left (Conventions say that this should be 'D')"}, 
	{"curkey":"right", "newkey": "A", "msg": "Let's bind a key for moving right. it has to be 'A'. It's the only sensible key to use for this purpose"}, 
	{"curkey":"djump", "newkey": "W", "msg": "This is the most important one: Bind double jump to 'W'!"}, 
]

var missing_actions = [
	{"action": "enter_mech", "bind": "Alt+F4"},
	{"action": "crafting", "bind": "Any key between '3' and '4'"},
	{"action": "live_chat", "bind": "@+|+Alt+*+' '+Shift"},
	{"action": "keybind", "bind": "Hold the power button for 3 seconds"}
]

var cur_key_idx = 0

func _ready():
	# get_node(rebindPath).hide()
	t("Aaahhhh! Of course you couldn't double-jump: Double-jump was bound to $...")
	yield(self, "enter_pressed")
	t("See this rebind all button? You can click the 'rebind all'-button to rebind all keys")
	var c = cursorscn.instance()
	get_parent().add_child(c)
	c.global_position = get_viewport().get_mouse_position()
	get_node(rebindPath).show()
	yield(self, "rebind_pressed")
	c.queue_free()
	get_node(rebindPath).hide()
	get_node(loadLabelPath).show()
	rebinding = true
	for k in correct_keys:
		t(k.msg)
		grid.get_node(k.curkey + "_bind").text = "_"
		yield(self, "correct_key_bound")
		grid.get_node(k.curkey + "_bind").text = k.newkey
	t("Sorry but you are taking waay too long, let me just fill out the rest of the keybindings with some accessibility friendly ones for you (Press enter to let me help you)")
	yield(self, "enter_pressed")
	t("...")
	$bindtimer.start()
	for k in missing_actions:
		grid.get_node(k.action + "_bind").text = k.bind
		$talk.pitch_scale = 1
		$talk.play()
		yield($bindtimer, "timeout")

	t("Now let's move on! (Press enter to move on)")
	yield(self, "enter_pressed")
	t("Yeah, you probably already knew you had to press enter to move on... (Press enter)")
	yield(self, "enter_pressed")
	t("I'm just trying to do my job, ok? (Press enter again)")
	yield(self, "enter_pressed")
	t("Thank you for being so understanding (Press enter)")
	yield(self, "enter_pressed")
	emit_signal("donebinding")
	
	


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
	if event is InputEventKey and rebinding and cur_key_idx < len(correct_keys) and not event.is_echo() and donetalking:
		if char(event.scancode) == correct_keys[cur_key_idx].newkey:
			emit_signal("correct_key_bound")
			cur_key_idx += 1

func _on_rebind_all():
	pass

func _on_rebind_pressed():
	if not rebinding:
		emit_signal("rebind_pressed")
	
