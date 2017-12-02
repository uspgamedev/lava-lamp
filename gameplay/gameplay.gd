extends Node2D

onready var input = get_node('/root/input')

func _ready():
	input.connect('press_quit', self, 'quit')

func quit():
	get_tree().quit()

func get_size():
	return Vector2(1280, 720)