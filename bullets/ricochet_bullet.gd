extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')
onready var sfx = get_node("SFX")

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	self.sfx.play("Fly")

func _physics_process(delta):
	if get_node("../../Floor").world_to_map(self.get_position()) > Vector2(70, 70) or get_node("../../Floor").world_to_map(self.get_position()) < Vector2(-10, -10):
		self.queue_free()
		
func apply_speed_scale(delta):
	var motionScale = self.speed * delta * self.speed_factor
	var motion = move_and_collide( motionScale )
	
	if (is_colliding()):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.reflect(motion)
		self.speed = normal.reflect(self.speed)
		self.sfx.play("Bounce")
		move_and_collide(motion)

func _queue_free():
	self.queue_free()
