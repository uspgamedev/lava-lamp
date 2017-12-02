extends 'res://characters/body.gd'

const DIR = preload('res://characters/player/input/directions.gd')

onready var input = get_node('/root/input')
onready var camera = get_node('Camera')
onready var ah = get_node('ActionHandler')

signal look_dir_changed(dir)

var dir = 0

func _ready():
	set_fixed_process(true)
	input.connect('hold_direction', self, '_add_speed')
	input.connect('hold_direction', self, '_set_look_dir')
	input.connect('press_action', self, '_act')
	#input.connect('hold_look', self, '_set_look_dir')
	
	ah.set_key_to_action(KEY_B, 'debug')
	ah.set_key_to_action(KEY_G, 'create_simple_bullet')
	ah.set_key_to_action(KEY_N, 'create_trap')
	ah.set_key_to_action(KEY_M, 'create_wormhole')
	ah.set_key_to_action(KEY_V, 'dash')

	load_camera()

func _set_look_dir(dir):
	if not Input.is_action_pressed("lock_dir"):
		self.dir = dir
		emit_signal("look_dir_changed", dir)

func get_look_dir():
	return DIR.VECTOR[self.dir]

func get_look_dir_value():
	return self.dir

func load_camera():
	camera.set_enable_follow_smoothing(true)
	camera.set_follow_smoothing(5)
	camera.make_current()

func deal_damage(d):
	self.damage += d
	if self.damage >= self.hp:
		get_tree().change_scene('res://main.tscn')