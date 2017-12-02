extends 'res://characters/body_fixed_speed.gd'

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area') or area.is_in_group('player_area'):
		var other = area.get_parent()
		var relative_pos = other.get_pos() - get_pos()
		var wh_list = get_tree().get_nodes_in_group("wormholes")
		var brother = wh_list[randi()%wh_list.size()]
		other.set_pos(brother.get_pos() - relative_pos)