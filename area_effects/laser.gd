extends 'res://area_effects/area_effect.gd'

onready var timer = get_node('Timer')

var pos = 0

func _ready():
	damage = 0.5
	timer.connect('timeout', self, 'queue_free')
	timer.start()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		area.get_parent().ai.hit(self)
