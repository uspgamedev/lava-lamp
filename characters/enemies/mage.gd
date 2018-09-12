extends 'enemy.gd'

signal teleporting

const DIR = preload('res://characters/player/input/directions.gd')

onready var ap

func _ready():
	ap = get_node("Sprite/AnimationPlayer")

func _physics_process(delta):
	var dir = self.get_look_dir_value()
	var moving = (self.get_speed_scale().length() > 0)
	var anim
	
	if not moving or dir == DIR.DOWN or dir == DIR.DOWN_LEFT or dir == DIR.DOWN_RIGHT:
		anim = "walk_down"
	elif dir == DIR.UP or dir == DIR.UP_LEFT or dir == DIR.UP_RIGHT:
		anim = "walk_up"
	elif dir == DIR.LEFT:
		anim = "walk_left"
	elif dir == DIR.RIGHT:
		anim = "walk_right"

	if anim != ap.get_current_animation():
		ap.play(anim)
