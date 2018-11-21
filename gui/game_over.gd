extends Control

func _ready():
	get_node('/root/input').set_control_type(get_node('/root/input').control_type)

func start():
	print('stop')
	get_node('/root/Main/BGM').stop()
	get_node('StreamPlayer').play()
	get_tree().set_pause(true)
	visible = true
	var w = get_node('/root/Main/WaveManager').cur_wave - 1
	get_node('WaveCount').set_text("You survived %d wave%s." % [w, "s" if w > 1 else ""])
	var props = get_node('/root/Main/Map/Props').get_children()
	for i in props:
		if i.is_in_group('enemy'):
			for child in i.get_children():
				if child.is_in_group('sfx'):
					child.stop()

func _on_Button_pressed():
	get_node('/root/Main/BGM').play()
	get_node('StreamPlayer').stop()
	get_tree().set_pause(false)
	visible = false
	get_tree().change_scene('res://main.tscn')
