extends 'res://characters/body_fixed_speed.gd'

onready var timer = get_node('Timer')
onready var sfx = get_node('SFX')

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	sfx.play("Shoot")

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.damage += 1
		if (enemy.damage >= enemy.hp):
			enemy.queue_free()
		self.queue_free()

func _queue_free():
	self.queue_free()
