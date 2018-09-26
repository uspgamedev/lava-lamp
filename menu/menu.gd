extends Control

func _ready():
	pass


func _on_Arcade_pressed():
	get_node('/root/game_mode').mode = 0
	get_tree().change_scene('res://main.tscn')


func _on_Survival_pressed():
	get_node('/root/game_mode').mode = 1
	get_tree().change_scene('res://main.tscn')


func _on_Quit_pressed():
	get_tree().quit()
