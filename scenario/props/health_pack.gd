extends Node2D

func _on_Area2D_area_entered(area):
	if area.get_parent().get_name() == "Player":
		var p = get_node("/root/Main/Map/Props/Player")
		if p.damage != 0:
			p.deal_damage(-1)
			queue_free()

