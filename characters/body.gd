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
	var motionScale = Vector2()

	if self.dashTime > 0:
		motionScale = self.speed * delta * DASHFACTOR
		self.dashTime -= delta
	else:
		motionScale = self.speed * delta
		self.dashTime = 0

	var motion = move_and_collide( motionScale )
	if (is_colliding()):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		self.speed = normal.slide(self.speed)
		move_and_collide(motion)

func deaccelerate():
	if (speed.length_squared() < EPSILON):
		speed = Vector2(0, 0)
	else:
		speed *= .5
