extends 'res://bullets/bullet.gd'

onready var sfx = get_node("SFX")

func _ready():
	sfx.play('Place')
	damage = 5

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit_by_bullet(enemy, self)