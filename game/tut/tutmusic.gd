extends Control

signal enter_pressed
signal right_pressed
signal esc_pressed
signal musicjokedone


var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	t("Let us find some nice, relaxing background music.")
	yield(self, "enter_pressed")
	$text.text = "Currently playing: 'Movement no. 271 in D-minor (the saddest key) by Bruder Johannes Sebastian Emanuel-Mattias'"
	$nice1.play()
	t("Hmm this is nice. But slightly too baroque-esque for my delicate palette. Press right arrow key to jump to the next track")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Take 4 by the Bave Drubeck Quartet'"
	$nice1.stop()
	$nice2.play()
	t("Oh I like this track, but I am maybe in the mood for something less jazzy right now.")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Dundun dundun dundun by Underground'"
	$nice2.stop()
	$nice3.play()
	t("This is an old classic, but we should be saving this track for the water level.")
	yield(self, "right_pressed")
	$nice3.stop()
	$techno.play()
	$text.text = "Currently playing: 'T3chn0-B4ss by VodkaNostroviaComrade'"
	t("Perfect! This is background music for heroic adventure")
	yield(self, "enter_pressed")
	t("Now that you have chosen the music, you can press escape to return to the game")
	yield(self, "esc_pressed")
	emit_signal("musicjokedone")
func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if(event.is_action_pressed("ui_right")):
		emit_signal("right_pressed")
	if(event.is_action_pressed("ui_cancel")):
		emit_signal("esc_pressed")
		
