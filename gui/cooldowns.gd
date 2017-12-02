extends Node2D

const gap = 70
const eps = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	for child in get_children():
		var nxy
		if abs(child.get_pos().y - child.correct_y) < eps:
			nxy = child.correct_y
		else:
			nxy = child.correct_y * .07 + child.get_pos().y * .93
		child.set_pos(Vector2(child.get_pos().x, nxy))

func fix_y():
	var y = 0
	for child in get_children():
		if not child.is_queued_for_deletion():
			child.correct_y = y
			y += gap

func add_cooldown(cd):
	var ct = 0
	for c in get_children():
		if not c.is_queued_for_deletion():
			ct += 1
	cd.set_pos(Vector2(cd.get_pos().x, gap * ct))
	add_child(cd)
	fix_y()