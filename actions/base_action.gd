extends Node

var on_cooldown
var cooldown_time = 1
var name = "dummy"
var auto_play = false

var icon = preload("res://gui/godot_icon.tscn")

func get_name():
	return name

func activate(action_handler, key):
	pass