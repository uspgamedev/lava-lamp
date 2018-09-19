extends KinematicBody2D

const DIR = preload('player/input/directions.gd')
const ACT = preload('player/input/actions.gd')

const ACC = 200
const EPSILON = 1
const DASHFACTOR = 8

var dashTime = 0
var speed = Vector2()

export(int, 1, 50) var hp = 4
var damage = 0
var motion

func _physics_process(delta):
	apply_speed_scale(delta)
	deaccelerate()

func _add_speed_scale(dir):
	self.speed += DIR.VECTOR[dir] * ACC

func get_speed_scale():
	return speed

func apply_speed_scale(delta):
	if self.dashTime > 0:
		self.speed *= DASHFACTOR
		self.dashTime -= delta
	else:
		self.dashTime = 0
	
	move_and_slide(self.speed)

func deaccelerate():
	if (speed.length_squared() < EPSILON):
		speed = Vector2(0, 0)
	else:
		speed *= .5
