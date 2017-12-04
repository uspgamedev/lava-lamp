extends Sprite

const DIR = preload('res://characters/player/input/directions.gd')

onready var player = get_parent()
onready var ap


func _ready():
	ap = get_node("AnimationPlayer")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var dir = player.get_look_dir_value()
	var shooting = player.is_shooting()
	var moving = (player.get_speed().length() > 0)
	var anim
		
	if dir == DIR.UP or dir == DIR.UP_LEFT or dir == DIR.UP_RIGHT:
		if moving and shooting:
			anim = "Fire_Walk_Up"
		elif shooting:
			anim = "Fire_Up"
		elif moving:
			anim = "Walk_Up"
		else:
			anim = "Idle_Up"
	elif dir == DIR.DOWN or dir == DIR.DOWN_LEFT or dir == DIR.DOWN_RIGHT:
		if moving and shooting:
			anim = "Fire_Walk_Down"
		elif shooting:
			anim = "Fire_Down"
		elif moving:
			anim = "Walk_Down"
		else:
			anim = "Idle_Down"
	elif dir == DIR.LEFT:
		if moving and shooting:
			anim = "Fire_Walk_Left"
		elif shooting:
			anim = "Fire_Left"
		elif moving:
			anim = "Walk_Left"
		else:
			anim = "Idle_Left"
	elif dir == DIR.RIGHT:
		if shooting and moving:
			anim = "Fire_Walk_Right"
		elif shooting:
			anim = "Fire_Right"
		elif moving:
			anim = "Walk_Right"
		else:
			anim = "Idle_Right"
	if anim != ap.get_current_animation():
		ap.play(anim)
