extends KinematicBody2D

const DIR = preload('player/input/directions.gd')
const ACT = preload('player/input/actions.gd')

const ACC = 100
const EPSILON = 1

var speed = Vector2()
var hp = 100
var motion

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	apply_speed(delta)
	deaccelerate()

func _add_speed(dir):
	self.speed += DIR.VECTOR[dir] * ACC

func apply_speed(delta):
	var motion = move(self.speed * delta)
	if (is_colliding()):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		self.speed = normal.slide(self.speed)
		move(motion)

func deaccelerate():
	if (speed.length_squared() < EPSILON):
		speed = Vector2(0, 0)
	else:
		speed *= .5
