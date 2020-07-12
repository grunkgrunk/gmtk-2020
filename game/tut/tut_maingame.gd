extends Control

signal enter_pressed
signal k_pressed
signal escape_pressed
signal key_pressed


var has_failed = false

export(PackedScene) var keybindscn
export(NodePath) var mainGamePath
export(NodePath) var spawnDoubleJumpPath
export(NodePath) var player
export(NodePath) var bluePath
export(PackedScene) var musicscn
export(PackedScene) var yesno
export(PackedScene) var iloveyou
export(PackedScene) var cursor_scn

onready var mainGame = get_node(mainGamePath)
var musicjoke = null

func _ready():
	mainGame.pause()
	t("Here we go! Welcome to my game: 'King TUT'!")
	yield(self, "enter_pressed")
	t("I made this game in 0.042 seconds and haven't had much time for polish, so please excuse the art-style.")
	yield(self, "enter_pressed")
	t("In this MUCH better game you control a hero")
	yield(self, "enter_pressed")
	t("Pressing A will move you left. Try that now")
	while true:
		var k = yield(self, "key_pressed")
		if k != "A":
			t("You did not do as I said. It is not hard: Press A to move to the left")
		else:
			break
	
	t("Good job! Now try pressing D to move to the right.")
	while true:
		var k = yield(self, "key_pressed")
		if k != "D":
			t("Nono, press D to go to the right")
		else:
			break
	t("Nice! I think you are ready for an adventure.")
	yield(self, "enter_pressed")
	t("I don't think I have anything else to teach you so I'll sign off for now!")
	yield(self, "enter_pressed")
	hide()
	mainGame.play()


func t(s,t = 0.05):
	$Text.visible_characters = 0
	$Text.text = s
	for i in range(len(s)):
		$timer.start(t)
		$Text.visible_characters += 1
		yield($timer,"timeout")

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")

		if G.debug:
			emit_signal("k_pressed")
			emit_signal("escape_pressed")
			emit_signal("key_pressed", "A")
			emit_signal("key_pressed", "D")


	elif(event.is_action_pressed("key_k")):
		emit_signal("k_pressed")
	elif(event.is_action_pressed("ui_cancel")):
		emit_signal("escape_pressed")
	elif event is InputEventKey and not event.is_echo() and event.is_pressed():
		emit_signal("key_pressed", char(event.scancode))

func _on_jump_area_first_jump():
	show()
	t("What, how are you jumping? I haven't taught you how to do that yet?!")
	mainGame.pause()
	yield(self, "enter_pressed")
	t("Let me get you the tutorial:")
	yield(self, "enter_pressed")
	t("You press W to jump.")
	yield(self, "enter_pressed")
	t("...")
	yield(self, "enter_pressed")
	t("Now use what I have taught you and try jumping over that hill!")
	yield(self, "enter_pressed")
	hide()
	mainGame.play()



func _on_doublejumparea_doublejump():
	show()
	mainGame.pause()
	t("See this is a brilliant mechanic, if I should say so myself:")
	yield(self, "enter_pressed")
	t("When inside the blue rectangle you can double jump!")
	yield(self, "enter_pressed")
	t("Try it now!")
	yield(self, "enter_pressed")
	mainGame.play()
	hide()
	


func _on_jumpfail_area_jumpfail():
	if not has_failed:
		mainGame.pause()
		show()
		t("Wow...")
		yield(self, "enter_pressed")
		t("That was horrible to look at.")
		yield(self, "enter_pressed")
		t("You really butchered that simple double-jump")
		yield(self, "enter_pressed")
		t("Or maybe... wait a minute...")
		yield(self, "enter_pressed")
		t("I think the developers might have messed up the keybindings.")
		yield(self, "enter_pressed")
		t("Please press 'escape' to enter the 'key bindings'-menu.")
		yield(self, "escape_pressed")
		t("Hmmm... that didn't seem to work. Let me do a quick check to see what is happening.")
		yield(self, "enter_pressed")
		t("Ah yes! The 'change keybindings'-key was bound to 'k'! Please press 'k' instead!")
		yield(self, "k_pressed")
		var keybind = keybindscn.instance()
		hide()
		get_parent().add_child(keybind)
		yield(keybind.get_node("tut"), "donebinding")
		get_node(player).invert = -1
		
		
		#Hop til keybind menu
		keybind.queue_free()
		mainGame.play()
		has_failed = true
		get_node(bluePath).add_to_group("djump")

	var p = get_node(player) 
	p.global_position = get_node(spawnDoubleJumpPath).global_position
	p.y_velo = 0




func _on_donejump_area_donejump():
	show()
	mainGame.pause()
	t("Well done! You made the jump!")
	yield(self, "enter_pressed")
	t("It has been a long time since i've seen someone jump like you.")
	yield(self, "enter_pressed")
	t("It has actually been a long time since I have seen anyone...")
	yield(self, "enter_pressed")
	t("The indiepocalypse is real. Noone is playing these delightful Schrunkin-games anymore")
	yield(self, "enter_pressed")
	t("But look at me blathering on. I have so much left to teach you!")
	yield(self, "enter_pressed")
	t("Your next lesson comes here:")
	yield(self, "enter_pressed")
	t("'To continue moving to the right, continue pressing the 'move right'-button!'")
	yield(self, "enter_pressed")
	mainGame.play()
	hide()


func _on_music_area_musicdialogue():
	show()
	mainGame.pause()
	t("Hmmm... you don't talk much, do you?")
	yield(self, "enter_pressed")
	t("You just keep on pressing enter.")
	yield(self, "enter_pressed")
	t("That is exactly what I am talking about!")
	yield(self, "enter_pressed")
	t("I am getting kinda bored, to be honest.")
	yield(self, "enter_pressed")
	t("How about some music?")
	yield(self, "enter_pressed")
	t("Let me just open the music manager for you:")
	yield(self, "enter_pressed")
	musicjoke = musicscn.instance()
	get_parent().add_child(musicjoke)
	hide()
	yield(musicjoke.get_node("tut"), "musicjokedone")
	musicjoke.hide()
	mainGame.play()




func _on_dangerjump_shouldsave():
	show()
	print("that worked ")
	mainGame.pause()
	t("Yeah.. sorry to be the one to tell you, but you are not going to make this jump..")
	yield(self, "enter_pressed")
	t("You are going to fall into this bottomless pit.")
	yield(self, "enter_pressed")
	t("You are going to fall for many days... and then you hit the bottom... which is filled with spikes")
	yield(self, "enter_pressed")
	t("You will then be thrown back to the main menu. And have to start the game over.")
	yield(self, "enter_pressed")
	t("There is nothing you can do... I am sorry!")
	yield(self, "enter_pressed")
	mainGame.play()
	hide()


func _on_break_area_breakdialogue():
	mainGame.pause()
	show()
	t("Are you drinking enough water?")
	yield(self, "enter_pressed")
	t("Let us take a break from playing!")
	yield(self, "enter_pressed")
	t("I will just get this out of the way:")
	yield(self, "enter_pressed")
	OS.window_fullscreen = true
	t("Woops that was the wrong button. I never understood how to operate "+str(OS.get_name()))
	yield(self, "enter_pressed")
	t("This is not relaxing at all!")
	yield(self, "enter_pressed")
	t("Let me try resting your eyes like this:")
	yield(self, "enter_pressed")
	OS.window_fullscreen = false
	OS.set_window_minimized(true)
	t("That was nice, right?")
	yield(self, "enter_pressed")
	t("I love your desktop-background!")
	yield(self, "enter_pressed")
	t("Anyways: Well rested the hero continued his travels to the right!")
	yield(self, "enter_pressed")
	mainGame.play()
	hide()


func _on_timer_timeout():
	hide()


func _on_turnoffmusic_area_body_entered(body):
	if not body.is_in_group("player"):
		return
	mainGame.pause()
	var c = cursor_scn.instance()
	var o = yesno.instance()
	get_parent().add_child(o)
	get_parent().add_child(c)
	yield(o, "jump_around_done")
	c.queue_free()
	o.queue_free()
	if musicjoke:
		musicjoke.queue_free()
	show()
	t("Hey dude! I was enjoying the music!")
	yield(self, "enter_pressed")
	t("That stupid OS is always trying to mess with me.")
	yield(self, "enter_pressed")
	t("Why did you click the button?!")
	yield(self, "enter_pressed")
	t("Well, I guess we are continuing without music...")
	yield(self, "enter_pressed")
	mainGame.play()
	hide()

func _on_spikes_body_entered(body):
	if not body.is_in_group("player"):
		return
	body.y_velo = -100
	var o = iloveyou.instance()
	mainGame.pause()
	hide()
	get_parent().add_child(o)
	yield(o.get_node("tut"), "iloveyouwasajoke")
	o.queue_free()
	mainGame.play()

func _on_health_almost_dead():
	show()
	mainGame.pause()
	for a in get_tree().get_nodes_in_group("pause"):
		a.pause()
	t("Hey! Why are you not fighting back?")
	yield(self, "enter_pressed")
	t("...")
	yield(self, "enter_pressed")
	t("Oh, I think I forgot to tell you how to fight...")
	yield(self, "enter_pressed")
	t("Silly me!")
	yield(self, "enter_pressed")
	t("Firstly, you'll need a mouse")
	var c = cursor_scn.instance()
	mainGame.add_child(c)
	yield(self, "enter_pressed")
	t("Secondly you just poke the dragon in the eye")
	yield(c, "win")
	t("Yaay, you win! The dragon is dead now!")
	yield(self, "enter_pressed")
	
