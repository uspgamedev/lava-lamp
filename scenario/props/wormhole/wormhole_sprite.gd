extends Node2D

onready var sprites = [
	get_node("Base"),
	get_node("Sprite"),
	get_node("Sprite1"),
	get_node("Sprite2"),
]

onready var arrow = get_node("Arrow")

func _ready():
	arrow.set_scale(Vector2(1, -1))

func set_brother():
	arrow.set_scale(Vector2(1, 1))
	arrow.set_color(Color(1, 0.4, 0))
	for sprite in sprites:
		sprite.set_modulate(Color(0.5, 1, 1))


