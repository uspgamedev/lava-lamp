extends 'res://characters/body.gd'

var fixed_speed = Vector2(0, 0)

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	self.speed += self.fixed_speed