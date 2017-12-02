extends 'res://characters/body_fixed_speed.gd'

var brother = false

func set_brother(b):
	brother = b
	get_node("Sprite").set_modulate(Color(0.5, 1, 1))

func _on_Area2D_area_enter(area):
	if (area.is_in_group('walls')):
		set_pos(randi()%1280, randi()%720)
	if (area.is_in_group('enemy_area') or area.is_in_group('player_area')) and brother:
		var other = area.get_parent()
		var mem = other.get_pos()
		other.set_pos(brother.get_pos())
		if (other.is_colliding()):
			other.set_pos(mem)