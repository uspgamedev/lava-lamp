extends Node2D

onready var tb_bg = get_node("Text Box BG")
onready var tb = get_node("Text Box")
onready var active = false

func _ready():
	pass
	
func activate_box():
	active = true
	var anim_player = tb_bg.get_node("AnimationPlayer")
	anim_player.play("Activate")
	
func deactivate_box():
	active = false
	var anim_player = tb_bg.get_node("AnimationPlayer")
	anim_player.play("Deactivate")
	tb.set_text("")

func is_active():
	return active

func display_text(text, time = 5):
	var timer = get_node("Deactivate Timer")
	if is_active():
		timer.stop()
	else:
		activate_box()
	tb.set_text(text)
	timer.set_wait_time(time)
	timer.start()
	
