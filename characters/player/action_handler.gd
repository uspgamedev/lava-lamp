extends Node2D

var action_map = []

func _ready():
	set_process_unhandled_key_input(true)
	action_map.resize(26)
	action_map[1] = preload('res://actions/debug.gd')
	action_map[2] = preload('res://actions/create_simple_bullet.gd')

func _unhandled_key_input(ev):
	var key = ev.scancode - KEY_A
	if key < 0 or key >= 26 or not ev.pressed or ev.echo:
		return
	if action_map[key] != null:
		action_map[key].activate(self)