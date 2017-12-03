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
	
func apply_speed(delta):
	move( self.speed * delta )
	
func get_speed():
	return speed
