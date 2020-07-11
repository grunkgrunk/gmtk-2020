extends Node


var debug = true

func _input(event):
    if event.is_action_pressed("debug"):
        debug = !debug