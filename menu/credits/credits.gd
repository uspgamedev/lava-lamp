extends Control

const QUIT_ACTIONS = ["ui_accept", "ui_cancel", "mouse_down"]


func _input(event):
	for action in QUIT_ACTIONS:
		if event.is_action_pressed(action):
			get_node('/root/bgm_global').play_intro()
			get_tree().change_scene("res://menu/menu.tscn")