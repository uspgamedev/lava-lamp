extends Node2D

onready var sprites = [
	get_node("Base"),
	get_node("Sprite"),
	get_node("Sprite1"),
	get_node("Sprite2"),
]

func set_modulate(color):
	for sprite in sprites:
		sprite.set_modulate(color)
