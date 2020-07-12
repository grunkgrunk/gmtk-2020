extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var l = $Line2D.points
	var n = []
	for x in l:
		n.append(x)
	for i in range(len(l)-1, 0, -1):
		n.append(l[i])
	
	$CollisionPolygon2D.polygon = n 
