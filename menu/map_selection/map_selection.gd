extends Control

onready var button_scene = preload("res://menu/map_selection/map_name.tscn")

func _ready():
	var index = 0
	for map in game_mode.maps:
		var button = button_scene.instance()
		button.text = map
		button.connect("pressed", self, "_button_pressed", [index])
		$Maps.add_child(button)
		index += 1
	

func _button_pressed(index):
	game_mode.selected_map = index
	
	if game_mode.mode == game_mode.SURVIVAL:
		get_tree().change_scene('res://gui/survivor_bind_screen.tscn')
	else:
		get_tree().change_scene('res://main.tscn')


func _on_Back_pressed():
	get_tree().change_scene("res://menu/menu.tscn")
