extends 'follow_player.gd'

func hit(obj):
	var enemy = get_parent()
	if obj is preload('res://bullets/bullet.gd'):
		if not obj is preload('res://bullets/trap.gd'):
			.hit(obj)
	elif obj is preload('res://area_effects/area_effect.gd'):
		.hit(obj)

