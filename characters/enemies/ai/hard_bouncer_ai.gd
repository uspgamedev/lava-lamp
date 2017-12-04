extends 'bouncer_ai.gd'

func hit(obj):
	var enemy = get_parent()
	if obj extends preload('res://bullets/bullet.gd'):
		if obj extends preload('res://bullets/trap.gd'):
			.hit(obj)
		elif obj extends preload('res://bullets/guided_bullet.gd'):
			emit_signal("bounced")
			obj.guided_speed = -obj.guided_speed
			obj.enemy = null
			obj.damages_player = true
		else:
			obj.speed = -obj.speed
			obj.damages_player = true
			emit_signal("bounced")
	elif obj extends preload('res://area_effects/area_effect.gd'):
		.hit(obj)