extends KinematicBody2D

var speed = Vector2(400, 400)

var damage = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	apply_speed(delta)
	
func apply_speed(delta):
	move( self.speed * delta )
	
func get_speed():
	return speed
