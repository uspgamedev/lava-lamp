extends Polygon2D

const DIR = preload('res://characters/player/input/directions.gd')


func _set_look_dir(dir):
	self.set_pos(Vector2(DIR.VECTOR[dir])*(35))
	if (dir < 4):
		self.set_rot(dir*-PI/2)
	else:
		self.set_rot(((dir-3)+dir%4)*-PI/4)


