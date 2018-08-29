extends 'res://characters/body.gd'

var fixed_speed = Vector2(0, 0)

func _ready():
	set_physics_process(true)

func _physics_process(dt):
	self.speed += self.fixed_speed
