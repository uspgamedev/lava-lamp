extends 'res://characters/body_fixed_speed.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	set_fixed_process(true)

func _fixed_process(delta):
	if (!main.is_a_valid_position(self.get_pos())):
		var floor_tile_map = get_node("../../Floor")
		var mem = self.get_pos()
		var actual = floor_tile_map.world_to_map(self.get_pos())
		self.revert_motion()
		var last = floor_tile_map.world_to_map(self.get_pos())
		print(self.fixed_speed)
		print(last, actual)
		self.fixed_speed = (last - actual).clamped(1).reflect(self.fixed_speed)
		print(self.fixed_speed)
		self.set_pos(mem + self.fixed_speed*delta)
	if get_node("../../Floor").world_to_map(self.get_pos()) > Vector2(50, 50) or get_node("../../Floor").world_to_map(self.get_pos()) < Vector2(-50, -50):
		self.queue_free()
		

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.damage += 1
		if (enemy.damage >= enemy.hp):
			enemy.queue_free()
		self.queue_free()

func _queue_free():
	self.queue_free()
