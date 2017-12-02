extends Sprite

const DIR = preload('res://characters/player/input/directions.gd')

onready var player = get_parent()
onready var ap


func _ready():
	ap = get_node("AnimationPlayer")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var dir = player.get_look_dir_value()
	var moving = (player.get_speed().length() > 0)
	var anim
	if dir == DIR.UP or dir == DIR.UP_LEFT or dir == DIR.UP_RIGHT:
		if moving:
			anim = "Walk_Up"
		else:
			anim = "Idle_Up"
	elif dir == DIR.DOWN or dir == DIR.DOWN_LEFT or dir == DIR.DOWN_RIGHT:
		if moving:
			anim = "Walk_Down"
		else:
			anim = "Idle_Down"
	elif dir == DIR.LEFT:
		if moving:
			anim = "Walk_Left"
		else:
			anim = "Idle_Left"
	elif dir == DIR.RIGHT:
		if moving:
			anim = "Walk_Right"
		else:
			anim = "Idle_Right"
	if anim != ap.get_current_animation():
		ap.play(anim)