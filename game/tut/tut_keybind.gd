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

onready var grid = get_node(gridPath)

var rebinding = false
var correct_keys = [
	{"curkey":"jump", "newkey": "W", "msg": "First press W to bind W to jump"}, 
	{"curkey":"left", "newkey": "D", "msg": "Now press a key to go left (it has to be D, it's the only sensible key to use for this purpose)"}, 
	{"curkey":"right", "newkey": "A", "msg": "Let's bind a key for moving right. Conventions say that this should be A"}, 
	{"curkey":"djump", "newkey": "W", "msg": "This is the most important one; bind this to W and it should be easier for you to double jump"}, 
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
	t("ÃÃÃÃÃÃÃÃh of course you couldn't jump, double jump was bound to the wrong key...")
	yield(self, "enter_pressed")
	t("See this rebind all button? You can click the button to rebind all keys")
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
	t("Thank you for being so understanding (You know what to do (Press enter))")
	yield(self, "enter_pressed")
	emit_signal("donebinding")
	
	


func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if event is InputEventKey and rebinding and cur_key_idx < len(correct_keys) and not event.is_echo():
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
