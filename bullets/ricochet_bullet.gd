extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')
onready var sfx = get_node("SFX")

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	set_fixed_process(true)
	self.sfx.play("Fly")

func _fixed_process(delta):
	if get_node("../../Floor").world_to_map(self.get_pos()) > Vector2(70, 70) or get_node("../../Floor").world_to_map(self.get_pos()) < Vector2(-10, -10):
		self.queue_free()
		
func apply_speed(delta):
	var motionScale = self.speed * delta * self.speed_factor
	var motion = move( motionScale )
	
	if (is_colliding()):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.reflect(motion)
		self.speed = normal.reflect(self.speed)
		self.sfx.play("Bounce")
		move(motion)

func _queue_free():
	self.queue_free()
