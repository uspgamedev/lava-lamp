extends 'shielded_follow.gd'

func hit(obj):
	if obj extends preload('res://bullets/trap.gd'):
		obj.queue_free()
	elif not obj extends preload('res://area_effects/area_effect.gd'):
		.hit(obj)