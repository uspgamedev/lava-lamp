extends Control

func _ready():
	get_node('/root/input').set_control_type(get_node('/root/input').control_type)

func start():
	get_node('/root/Main/BGM').stop()
	get_node('StreamPlayer').play()
	get_tree().set_pause(true)
	set_hidden(false)
	var w = get_node('/root/Main/WaveManager').cur_wave
	get_node('WaveCount').set_text("You survived %d wave%s." % [w, "s" if w > 1 else ""])

func _on_Button_pressed():
	get_node('/root/Main/BGM').play()
	get_node('StreamPlayer').stop()
	get_tree().set_pause(false)
	set_hidden(true)
	get_tree().change_scene('res://main.tscn')