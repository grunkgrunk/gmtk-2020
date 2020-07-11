extends Control

signal enter_pressed
signal k_pressed
signal escape_pressed

export(NodePath) var mainGamePath

onready var mainGame = get_node(mainGamePath)

func t(s):
	$Text.text = s

func _input(event):
	if(event.is_action_pressed("continue")):
		emit_signal("enter_pressed")
	if(event.is_action_pressed("key_k")):
		emit_signal("k_pressed")
	if(event.is_action_pressed("ui_cancel")):
		emit_signal("escape_pressed")

func _on_jump_area_first_jump():
	t("What, how can you jump now, I havent' taught you how to do that")
	mainGame.pause()
	yield(self, "enter_pressed")
	mainGame.play()



func _on_doublejumparea_doublejump():
	mainGame.pause()
	t("See this is a brilliant mechanic:")
	yield(self, "enter_pressed")
	t("When inside the blue rectangle you can double jump!")
	yield(self, "enter_pressed")
	t("Try it now!")
	yield(self, "enter_pressed")
	mainGame.play()
	


func _on_jumpfail_area_jumpfail():
	mainGame.pause()
	t("Wow that was horrible to look at.")
	yield(self, "enter_pressed")
	t("You really butchered that simple double-jump")
	yield(self, "enter_pressed")
	t("Or maybe... wait a minute...")
	yield(self, "enter_pressed")
	t("I think the developers might have messed up the keybindings.")
	yield(self, "enter_pressed")
	t("Please press escape so we can check the menu.")
	yield(self, "escape_pressed")
	t("Hmmm... that didn't seem to work")
	yield(self, "enter_pressed")
	t("Ah yes! I think the 'change keybindings'-key was bound to 'k'! Please press 'k'!")
	yield(self, "k_pressed")
	#Hop til keybind menu


func _on_donejump_area_donejump():
	mainGame.pause()
	t("Well done! You made the jump!")
	yield(self, "enter_pressed")
	t("It has been a long time since i've seen someone jump like you.")
	yield(self, "enter_pressed")
	t("It has actually been a long time since I have seen anyone...")
	yield(self, "enter_pressed")
	t("The indiepocalypse is real. Noone is playing these delightful Schrunkin-games")
	yield(self, "enter_pressed")
	t("But look at me blathering on. Let's keep moving! I have so much left to teach you!")
	yield(self, "enter_pressed")
	t("'To continue moving to the right, press the 'move right'-button!'")
	mainGame.play()


func _on_music_area_musicdialogue():
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



func _on_dangerjump_shouldsave():
	mainGame.pause()
	t("Yeah.. sorry to be the one to tell you, but you are not going to make this jump..")
	yield(self, "enter_pressed")
	t("You are going to fall into this bottomless pit.")
	yield(self, "enter_pressed")
	t("You are goin to fall for hours and days... until you hit the bottom... which is filled with spikes")
	yield(self, "enter_pressed")
	t("You will then be thrown back to the main menu. And have to start the game over.")
	yield(self, "enter_pressed")
	t("There is nothing you can do...")
	yield(self, "enter_pressed")
	mainGame.play()


func _on_break_area_breakdialogue():
	#mainGame.pause()
	t("Are you drinking enough water?")
	yield(self, "enter_pressed")
	t("Let us take a break from playing!")
	yield(self, "enter_pressed")
	OS.set_window_maximized(true)
	t("Woops that was the wrong button. I never understood how to operate "+str(OS.get_name()))
	yield(self, "enter_pressed")
	OS.set_window_minimized(true)
	t("That was nice, right?")
	yield(self, "enter_pressed")
	t("I love you desktop-background!")
	yield(self, "enter_pressed")
	t("Anyways: Well rested the hero continued his travels to the right!")
	#mainGame.play()
	
