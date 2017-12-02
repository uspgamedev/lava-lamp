extends 'res://characters/body.gd'

const DIR = preload('res://characters/player/input/directions.gd')

onready var input = get_node('/root/input')
onready var camera = get_node('Camera')

var dir = 0

func _ready():
	set_fixed_process(true)
	input.connect('hold_direction', self, '_add_speed')
	input.connect('press_action', self, '_act')
	input.connect('hold_look', self, '_set_look_dir')
	load_camera()

func _set_look_dir(dir):
	self.dir = dir

func get_look_dir():
	return DIR.VECTOR[self.dir]

func load_camera():
	camera.set_enable_follow_smoothing(true)
	camera.set_follow_smoothing(5)
	camera.make_current()

func deal_damage(d):
	self.damage += d
	if self.damage >= self.hp:
		get_tree().change_scene('res://main.tscn')