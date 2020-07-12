extends KinematicBody2D

signal took_damage
const MOVE_SPEED = 300
const JUMP_FORCE = 700
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var invert = 1


#onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
export(bool)var playing = false
var y_velo = 0
var facing_right = false

func _ready():
	$Camera2D.make_current()

func _physics_process(delta):
	if not playing:
		return
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	
	move_and_slide(Vector2(move_dir*invert * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if (grounded or in_blue_area()) and Input.is_action_just_pressed("ui_up"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 0:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	
	#if grounded:
#		if move_dir == 0:
#			play_anim("idle")
#		else:
#			play_anim("walk")
#	else:
#		play_anim("jump")

func in_blue_area():
	for a in $djump_area.get_overlapping_areas():
		if a.is_in_group("djump"):
			return true
	return false

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

#func play_anim(anim_name):
	#if anim_player.is_playing() and anim_player.current_animation == anim_name:
#		return
#anim_player.play(anim_name)


func _on_djump_area_area_entered(area):
	if area.owner.is_in_group("fireball"):
		print("yo")
		emit_signal("took_damage")
