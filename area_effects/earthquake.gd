extends 'res://area_effects/area_effect.gd'

onready var timer = get_node('Timer')

func _ready():
	damage = 2
	timer.connect('timeout', self, 'queue_free')
	timer.start()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit(self)
