extends KinematicBody2D

signal took_damage
const MOVE_SPEED = 100
const JUMP_FORCE = 700
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

var invert = 1

var can_land = true

onready var anim_player = $anim_player
onready var sprite = $pivot/Sprite
export(bool)var playing = false
var y_velo = 0
var facing_right = false
var grounded = false
func _ready():
	$Camera2D.make_current()

func _physics_process(delta):
	if not playing:
		$anim_player.stop(false)
		return
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	
	move_and_slide(Vector2(move_dir*invert * MOVE_SPEED, y_velo), Vector2(0, -1))

	grounded = is_on_floor()
	y_velo += GRAVITY
	if (grounded or in_blue_area()) and Input.is_action_just_pressed("ui_up"):
		y_velo = -JUMP_FORCE
		play_anim("jump")
		$jump.play()
	if grounded and y_velo >= 0:
		y_velo = 1
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if abs(y_velo) > 200:
		can_land = true
	
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	
	if grounded:
		if can_land:
			$land.play()
			can_land = false
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")

func walk_sound():
	if grounded:
		get_node("walk" + str(randi() % 4 + 1)).play()

func in_blue_area():
	for a in $djump_area.get_overlapping_areas():
		if a.is_in_group("djump"):
			return true
	return false

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)


func _on_djump_area_area_entered(area):
	if area.owner.is_in_group("fireball"):
		emit_signal("took_damage")
		$Camera2D.shake(0.2, 15, 10)
		
