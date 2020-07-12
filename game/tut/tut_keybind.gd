extends Control

signal enter_pressed
signal rebind_pressed
signal correct_key_bound
signal timeout
signal donebinding

export(NodePath) var gridPath
export(NodePath) var rebindPath
export(NodePath) var loadLabelPath
export(PackedScene) var cursorscn

var c = 0
var maxlook = 10
onready var startpos = $tut.global_position
onready var eyes = ["tuteye","tuteye2"]
onready var grid = get_node(gridPath)
var donetalking = true

var rebinding = false
var correct_keys = [
	{"curkey":"jump", "newkey": "W", "msg": "First press 'W' to bind 'W' to jump"}, 
	{"curkey":"left", "newkey": "D", "msg": "Now press a key to go left (Conventions say that this should be 'D')"}, 
	{"curkey":"right", "newkey": "A", "msg": "Let's bind a key for moving right. it has to be 'A'. It's the only sensible key to use for this purpose"}, 
	{"curkey":"djump", "newkey": "W", "msg": "This is the most important one; bind this to 'W' and it should be easier for you to double jump"}, 
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
	t("Aaahhhh! Of course you couldn't double-jump: Double-jump was bound to the wrong key...")
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
		yield(self, "correct_key_bound")
		grid.get_node(k.curkey + "_bind").text = k.newkey
	t("Sorry but you are taking waay too long, let me just fill out the rest of the keybindings with some accessibility friendly ones for you")
	yield(self, "enter_pressed")
	t("...")
	$timer.start()
	for k in missing_actions:
		grid.get_node(k.action + "_bind").text = k.bind
		yield(self, "timeout")

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
	

func _on_timer_timeout():
	emit_signal("timeout")

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

