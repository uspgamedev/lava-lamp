extends 'enemy.gd'

const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = [
	"up", "down"
]

var last_dir = -1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var temp = get_speed()
	var dir = temp.y/abs(temp.y)
	if dir != self.last_dir:
		var append = ""
		if self.speed.length_squared() > 1:
			append = "_moving"
		else:
			dir = last_dir
		if dir == 1:
			anim.set_current_animation(DIR_ANIMS[1] + append)
		else:
			anim.set_current_animation(DIR_ANIMS[0] + append)
		last_dir = dir
