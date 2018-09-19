extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')
onready var sfx = get_node("SFX")

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	self.sfx.get_node("Fly").play()

func _physics_process(delta):
	if get_node("../../Floor").world_to_map(self.get_position()) > Vector2(70, 70) or get_node("../../Floor").world_to_map(self.get_position()) < Vector2(-10, -10):
		self.queue_free()
		
func apply_speed_scale(delta):
	var motionScale = self.speed * delta * self.speed_factor
	var kinematic_collision = move_and_collide( motionScale )
	
	if kinematic_collision != null and kinematic_collision.collider is TileMap:
		kinematic_collision = kinematic_collision.normal.reflect(kinematic_collision)
		self.speed = normal.reflect(self.speed)
		self.sfx.get_node("Bounce").play()
		move_and_collide(kinematic_collision)

func _queue_free():
	self.queue_free()
