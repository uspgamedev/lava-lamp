extends KinematicBody2D

const DIR = preload("res://characters/player/input/directions.gd")

onready var sprite = get_node("Sprite")

var speed = Vector2(400, 400)

var damage = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	apply_speed(delta)
	sprite.set_rot(DIR.vec2rot(self.speed))
	if (is_colliding_with_wall(self)):
		self.queue_free()
	
func apply_speed(delta):
	move( self.speed * delta )
	
func get_speed():
	return speed

func is_colliding_with_wall(bullet):
	if (bullet.is_colliding() and bullet.get_collider().get_type() == 'TileMap'):
		if (bullet.get_collider().get_cell(bullet.get_pos().x, bullet.get_pos().y) == -1):
			return true
	return false
