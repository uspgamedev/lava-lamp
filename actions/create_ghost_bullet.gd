extends 'base_action.gd'

const GhostBullet = preload('res://bullets/ghost_bullet.tscn')

func _init():
	cooldown_time = 3
	name = "ghost_bullet"

func activate(action_handler):
	#self.icon = preload("res://bullets/ghost_bullet_icon.tscn")
	var b = GhostBullet.instance()	
	var pl = action_handler.get_parent()
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 300
	pl.get_parent().add_child(b)