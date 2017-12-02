extends 'res://scripts/body.gd'

onready var input = get_node('/root/input')

func _ready():
	set_fixed_process(true)
	input.connect('hold_direction', self, '_add_speed')
	input.connect('press_action', self, '_fire')

func _fire(act):
	print('fire')
