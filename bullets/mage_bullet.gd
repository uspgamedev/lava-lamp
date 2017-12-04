extends 'simple_bullet.gd'

func _on_Area2D_area_enter(area):
	if area.get_parent().get_name() == 'Player':
		var player = area.get_parent()
		player.deal_damage(1)
		queue_free()