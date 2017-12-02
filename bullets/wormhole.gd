extends 'res://characters/body_fixed_speed.gd'

export(int) var id = 0

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area') or area.is_in_group('player_area'):
		var other = area.get_parent()
		var relative_pos = other.get_pos() - get_parent().get_pos() - get_pos()
		var brother = get_parent().get_node("Portal" + str(1 - id))
		print(relative_pos)
		other.set_pos(get_parent().get_pos() + brother.get_pos() - relative_pos)
		