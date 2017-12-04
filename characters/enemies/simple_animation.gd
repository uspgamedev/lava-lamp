extends Sprite

const DIR = preload('res://characters/player/input/directions.gd')

onready var enemy = get_parent()
onready var ap

func _ready():
	ap = get_node("AnimationPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	var dir = enemy.get_look_dir_value()
	var moving = (enemy.get_speed().length() > 0)
	var anim

	if dir == DIR.UP or dir == DIR.UP_LEFT or dir == DIR.UP_RIGHT:
		anim = "Walk_Up"
	elif dir == DIR.DOWN or dir == DIR.DOWN_LEFT or dir == DIR.DOWN_RIGHT:
		anim = "Walk_Down"
	elif dir == DIR.LEFT:
		anim = "Walk_Left"
	elif dir == DIR.RIGHT:
		anim = "Walk_Right"

	if anim != ap.get_current_animation():
		ap.play(anim)