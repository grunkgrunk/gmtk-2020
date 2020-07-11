extends Control

signal enter_pressed
signal rebind_pressed
signal correct_key_bound


export(NodePath) var gridPath
export(NodePath) var rebindPath

onready var grid = get_node(gridPath)

var rebinding = false
var correct_keys = [
	"W", 
	"A", 
	"D", 
	"W", 
	"O", 
	"C", 
	"S", 
	"K"
]

var cur_key_idx = 0

func _ready():
	# get_node(rebindPath).hide()
	t("ÃÃÃÃÃÃÃÃh of course you couldn't jump, double jump was bound to the wrong key...")
	yield(self, "enter_pressed")
	t("See this rebind all button? You can click the button to rebind all keys")
	yield(self, "enter_pressed")
	t("Nice, you are reeally getting the hang of it")
	yield(self, "rebind_pressed")
	rebinding = true
	for k in correct_keys:
		pass


func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if event is InputEventKey and rebinding:
		if char(event.scancode) == correct_keys[cur_key_idx]:
			emit_signal("correct_key_bound")

func _on_rebind_all():
	pass

func _on_rebind_pressed():
	emit_signal("rebind_pressed")
	

