extends Node2D

const gap = 70

func fix_y(obj):
	var y = 0
	for child in get_children():
		if obj != child:
			child.set_pos(Vector2(child.get_pos().x, y))
			y += gap

func add_cooldown(cd):
	add_child(cd)
	fix_y(null)