extends 'enemy.gd'

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = [
	"move_up", "move_down"
]

var last_dir = -1

func _ready():
	hp = 3

func _physics_process(delta):
	var temp = get_speed_scale()
	var dir = temp.y/abs(temp.y)
	if dir != self.last_dir:
		if dir == 1:
			anim.set_current_animation(DIR_ANIMS[1])
		else:
			anim.set_current_animation(DIR_ANIMS[0])
		last_dir = dir
