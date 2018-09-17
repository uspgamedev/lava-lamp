extends KinematicBody2D

const DIR = preload("res://characters/player/input/directions.gd")

onready var sprite = get_node("Sprite")

var speed = Vector2(400, 400)

export var damage = 1
export var speed_factor = 1.5
export var damages_player = false

func _physics_process(delta):
	apply_speed_scale(delta)
	sprite.set_rotation(self.speed.angle())

func apply_speed_scale(delta):
	var kinematic_collision = move_and_collide(self.speed * delta * self.speed_factor)
	if kinematic_collision != null and kinematic_collision.collider is TileMap:
		self.queue_free()

func get_speed_scale():
	return speed

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		var enemy = area.get_parent()
		enemy.ai.hit(self)
	if damages_player and area.get_parent().get_name() == 'Player':
		var player = area.get_parent()
		player.deal_damage(self.damage)
		queue_free()
