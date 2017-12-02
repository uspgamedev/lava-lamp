extends 'res://characters/body_fixed_speed.gd'

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		self.queue_free()
