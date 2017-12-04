extends 'res://bullets/bullet.gd'

onready var sfx = get_node("SFX")

func _ready():
	sfx.play('Place')
	damage = 5