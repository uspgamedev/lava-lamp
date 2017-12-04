extends 'follow_player.gd'

const DIR = preload('res://characters/player/input/directions.gd')

func hit(obj):
	var enemy = get_parent()
	var d = enemy.get_look_dir_value()

	if obj extends preload('res://bullets/bullet.gd'):
		if (d == DIR.UP and enemy.get_node('UpShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.DOWN and enemy.get_node('DownShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.LEFT and enemy.get_node('LeftShield').overlaps_area(obj.get_node('Area2D'))) or \
		   (d == DIR.RIGHT and enemy.get_node('RightShield').overlaps_area(obj.get_node('Area2D'))):
			if obj extends preload('res://bullets/trap.gd'):
				.hit(obj)
			else:
				obj.queue_free()
		else:
			.hit(obj)
	elif obj extends preload('res://area_effects/area_effect.gd'):
		.hit(obj)
