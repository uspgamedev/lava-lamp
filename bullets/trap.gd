extends 'res://bullets/bullet.gd'

onready var sfx = get_node("SFX")

func _ready():
	sfx.play('Place')

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.damage += 1
		if (enemy.damage >= enemy.hp):
			enemy.queue_free()
		self.queue_free()
