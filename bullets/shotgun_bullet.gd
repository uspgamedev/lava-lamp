extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var sfx = get_node('SFX')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, 'queue_free')
	timer.start()