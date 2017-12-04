extends 'base_action.gd'

const poly = Vector2Array([Vector2(-8, -16), Vector2(8, -16),
						   Vector2(8, 16), Vector2(-8, 16)])

func _init():
	cooldown_time = 5
	name = 'laser'

func activate(action_handler, key):
	var Laser = preload('res://area_effects/laser.tscn')
	var LaserTile = preload('res://area_effects/laser_tile.tscn')
	var pl = action_handler.get_parent()
	var wall_tm = pl.get_parent()
	var b = Laser.instance()
	var look_ang = pl.get_look_dir().angle()
	var look_dir = pl.get_look_dir().normalized()
	var beg = pl.get_pos() + Vector2(0, -20) + 16*look_dir
	for i in range(40):
		var pos = beg + i*32*look_dir
		var map = wall_tm.world_to_map(pos)
		if (wall_tm.get_cell(map.x, map.y) != -1):
			break
		var tile = LaserTile.instance()
		tile.set_pos(pos)
		tile.set_rot(look_ang)
		tile.get_node("Area2D").connect("area_enter", b, "_on_Area2D_area_enter")
		b.add_child(tile)
#		var img = Polygon2D.new()
#		img.set_polygon(poly)
#		img.set_pos(pos)
#		img.set_rot(look_ang)
#		img.set_color(Color(0, 0.8, 0.8))
#		b.add_child(img)
#		var col = CollisionPolygon2D.new()
#		col.set_polygon(poly)
#		col.set_pos(pos)
#		col.set_rot(look_ang)
#		b.get_node("Area2D").add_child(col)
	wall_tm.add_child(b)