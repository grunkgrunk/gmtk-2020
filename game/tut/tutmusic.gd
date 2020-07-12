extends Control

signal enter_pressed
signal right_pressed
signal esc_pressed
signal musicjokedone

var bass = false
var donetalking = true
var i = 0

onready var cs = get_tree().get_nodes_in_group("Camera")
# Called when the node enters the scene tree for the first time.
func _ready():
	t("Let us find some nice, relaxing background music.")
	yield(self, "enter_pressed")
	$text.text = "Currently playing: 'Movement no. 271 in D-minor (the saddest key)' by Bruder Johannes Sebastian Emanuel-Mattias"
	$nice1.play()
	t("Hmm this is nice. But slightly too baroque-esque for my delicate palette. Move right to jump to the next track")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Take 4' by the Bave Drubeck Quartet"
	$nice1.stop()
	$nice2.play()
	t("Oh I like this track, but I am maybe in the mood for something less jazzy right now.")
	yield(self, "right_pressed")
	$text.text = "Currently playing: 'Death Underground' by Underground Death"
	$nice2.stop()
	$nice3.play()
	t("This is an old classic, but we should be saving this track for the water level.")
	yield(self, "right_pressed")
	$nice3.stop()
	$techno.play()
	bass = true
	$text.text = "Currently playing: 'T3chn0-B4ss' by VodkaNostroviaComrade"
	t("Perfect! This is background music for a heroic adventure")
	yield(self, "enter_pressed")
	t("Now that you have chosen the music, you can press escape to return to the game")
	yield(self, "esc_pressed")
	emit_signal("musicjokedone")
	

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
	if not donetalking:
		return
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if(event.is_action_pressed("ui_right")):
		emit_signal("right_pressed")
	if(event.is_action_pressed("ui_cancel")):
		emit_signal("esc_pressed")
		
