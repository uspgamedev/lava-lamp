extends 'res://area_effects/area_effect.gd'

onready var timer = get_node('Timer')
onready var sprite = get_node('Sprite')

func _ready():
	damage = 4
	timer.connect('timeout', self, 'queue_free')
	timer.start()
	self.sprite.set_emitting(true)

func _on_Area2D_area_entered(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit(self)
