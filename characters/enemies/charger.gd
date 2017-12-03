extends 'enemy.gd'

const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = [
	"up", "down", "down", "down"
]

var last_dir = -1

func _ready():
	hp = 10

func _fixed_process(delta):
	var dir = self.get_look_dir_value()
	if dir != self.last_dir:
		var append = ""
		if self.speed.length_squared() > 1:
			append = "_moving"
		else:
			dir = last_dir
		anim.set_current_animation(DIR_ANIMS[dir] + append)
		last_dir = dir

	