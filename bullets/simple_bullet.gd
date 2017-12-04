extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, 'queue_free')
	timer.start()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit(self)
	if damages_player and area.get_parent().get_name() == 'Player':
		var player = area.get_parent()
		player.deal_damage(self.damage)
		queue_free()
	