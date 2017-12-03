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

func display_text(text):
	var text_tween = get_node("Text Tween")
	
	if is_active():
		var timer = get_node("Deactivate Timer")
		timer.stop()
		text_tween.stop()
	else:
		activate_box()
		
	tb.set_text(text)
	tb.set_visible_characters(0)
	var len = text.length()
	var text_speed = 10
	var d = len/text_speed
	text_tween.interpolate_property(tb, "visible_characters", 0, text.length(), d, Tween.TRANS_LINEAR, Tween.EASE_IN, .3)
	text_tween.start()
	

func _text_tween_complete( object, key ):
	start_deactivate_timer()
	
func start_deactivate_timer():
	print("ending")
	var timer = get_node("Deactivate Timer")
	timer.start()

