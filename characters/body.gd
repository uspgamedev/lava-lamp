extends KinematicBody2D

const DIR = preload('player/input/directions.gd')
const ACT = preload('player/input/actions.gd')

const ACC = 100
const EPSILON = 1
const DASHFACTOR = 8

var dashTime = 0
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
	var motionScale = Vector2()

	if self.dashTime > 0:
		motionScale = self.speed * delta * DASHFACTOR
		self.dashTime -= delta
	else:
		motionScale = self.speed * delta
		self.dashTime = 0

	var motion = move( motionScale )
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
