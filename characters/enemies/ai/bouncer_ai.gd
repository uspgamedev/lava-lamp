extends 'follow_player.gd'

signal bounced

func _ready():
	knockback = 8000
	enemy_dmg = 2

func collided_with_player(player):
	emit_signal("bounced")
	.collided_with_player(player)

func hit(obj):
	var enemy = get_parent()
	if obj is preload('res://bullets/bullet.gd'):
		if enemy.stunned > 0:
			.hit(obj)
		elif obj is preload('res://bullets/ion_bullet.gd'):
			.hit(obj)
		elif obj is preload('res://bullets/trap.gd'):
			.hit(obj)
		elif obj is preload('res://bullets/guided_bullet.gd'):
			emit_signal("bounced")
			obj.guided_speed = -obj.guided_speed
			obj.enemy = null
		else:
			obj.speed = -obj.speed
			emit_signal("bounced")
	elif obj is preload('res://area_effects/area_effect.gd'):
		.hit(obj)
