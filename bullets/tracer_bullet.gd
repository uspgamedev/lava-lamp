extends 'res://bullets/simple_bullet.gd'

func _ready():
	damage = 2

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit_by_bullet(enemy, self)