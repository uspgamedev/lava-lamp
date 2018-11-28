extends Button

func _on_QuitButton_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://menu/menu.tscn")