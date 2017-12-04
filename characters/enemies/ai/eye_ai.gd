extends 'follow_player.gd'

func hit(obj):
	var enemy = get_parent()
	if obj extends preload('res://bullets/bullet.gd'):
		.hit(obj)
	elif obj extends preload('res://area_effects/area_effect.gd'):
		if not obj extends preload('res://area_effects/earthquake.gd'):
			.hit(obj)
