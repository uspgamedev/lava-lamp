extends 'follow_player.gd'

signal bounced

func _ready():
	knockback = 8000
	enemy_dmg = 2

func hit(obj):
	var enemy = get_parent()
	if obj extends preload('res://bullets/bullet.gd'):
		if obj extends preload('res://bullets/trap.gd'):
			.hit(obj)
		elif obj extends preload('res://bullets/guided_bullet.gd'):
			emit_signal("bounced")
			obj.guided_speed = -obj.guided_speed
			obj.enemy = null
		else:
			obj.speed = -obj.speed
			emit_signal("bounced")
	elif obj extends preload('res://area_effects/area_effect.gd'):
		pass
