extends Control

signal enter_pressed
signal right_pressed

var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	t("Let us find some nice, relaxing background music.")
	yield(self, "enter_pressed")
	t("Press the right arrow key to jump to the next track")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Movement no. 271 in D-minor (the saddest key) by Bruder Johannes Sebastian Emanuel-Mattias'"
	t("Hmm this is nice. But slightly too baroque-esque for my delicate palette.")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Take 4 by the Bave Drubeck Quartet'"
	t("Oh I like this track, but I am maybe in the mood for something less jazzy right now.")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Aquatic Ambulance by Cing Cong Contry'"
	t("This is an old classic, but we should be saving this track for the water level.")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Movement no. 271 in D-minor (the saddest key) by Bruder Johannes Sebastian Emanuel-Mattias'"
	t("Perfect! This is background music for heroic adventure")

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if(event.is_action_pressed("ui_right")):
		emit_signal("right_pressed")
		
