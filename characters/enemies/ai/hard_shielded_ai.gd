extends 'shielded_follow.gd'

func hit(obj):
	if obj is preload('res://bullets/trap.gd'):
		obj.queue_free()
	elif not obj is preload('res://area_effects/area_effect.gd'):
		.hit(obj)
