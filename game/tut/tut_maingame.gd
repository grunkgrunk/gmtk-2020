extends Control

signal enter_pressed
signal k_pressed
signal escape_pressed

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
	yield(self, "enter_pressed")



func _on_doublejumparea_doublejump():
	t("See this is a brilliant mechanic:")
	yield(self, "enter_pressed")
	t("When inside the blue rectangle you can double jump!")
	yield(self, "enter_pressed")
	t("Try it now!")
	yield(self, "enter_pressed")
	


func _on_jumpfail_area_jumpfail():
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
