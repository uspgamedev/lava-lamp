extends KinematicBody2D

const DIR = preload("res://characters/player/input/directions.gd")

onready var sprite = get_node("Sprite")

export var speed_factor = 1

var speed = Vector2(400, 400)# * speed_factor

export var damage = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	apply_speed(delta)
	sprite.set_rot(DIR.vec2rot(self.speed))
	if (is_colliding_with_wall(self)):
		self.queue_free()

func apply_speed(delta):
	move(self.speed * delta * self.speed_factor)

func get_speed():
	return speed

func is_colliding_with_wall(bullet):
	if (bullet.is_colliding() and bullet.get_collider().get_type() == 'TileMap'):
		print("collide")
		return true
	return false
