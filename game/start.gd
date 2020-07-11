extends Control

signal start_pressed

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	emit_signal("start_pressed")
