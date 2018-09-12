extends 'res://characters/body.gd'

var fixed_speed = Vector2(0, 0)

func _physics_process(dt):
	self.speed += self.fixed_speed
