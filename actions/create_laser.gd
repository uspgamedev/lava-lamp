extends 'base_action.gd'

func _init():
	cooldown_time = 1
	name = 'laser'

func activate(action_handler):
	var Laser = preload('res://area_effects/laser.tscn')
	var pl = action_handler.get_parent()
	var wall_tm = pl.get_parent()
	var bs = []
	var look_ang = pl.get_look_dir().angle()
	var look_dir = pl.get_look_dir().normalized()
	var beg = pl.get_pos() + Vector2(0, -20) + 16*look_dir
	for i in range(40):
		bs.push_back(Laser.instance())
		var pos = beg + i*32*look_dir
		var map = wall_tm.world_to_map(pos)
		if (wall_tm.get_cell(map.x, map.y) != -1):
			break
		bs[i].set_pos(pos)
		bs[i].set_rot(look_ang)
		bs[i].pos = i
		pl.get_parent().add_child(bs[i])