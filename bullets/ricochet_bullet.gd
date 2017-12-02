extends 'res://characters/body_fixed_speed.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	set_fixed_process(true)

func _fixed_process(delta):
	if get_node("../../Floor").world_to_map(self.get_pos()) > Vector2(50, 50) or get_node("../../Floor").world_to_map(self.get_pos()) < Vector2(-50, -50):
		self.queue_free()
		
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
		motion = normal.reflect(motion)
		self.fixed_speed = normal.reflect(self.fixed_speed)
		move(motion)
	


func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.damage += 1
		if (enemy.damage >= enemy.hp):
			enemy.queue_free()
		self.queue_free()

func _queue_free():
	self.queue_free()
