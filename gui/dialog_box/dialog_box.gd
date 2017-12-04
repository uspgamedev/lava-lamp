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
	
	#Create gradual text effect
	var len = text.length()
	var text_speed = 20
	var d = len/text_speed
	var delay = .3
	text_tween.interpolate_property(tb, "visible_characters", 0, text.length(), d, Tween.TRANS_LINEAR, Tween.EASE_IN, delay)
	text_tween.start()
	
	#Make cientist talk while text appear
	var portrait = get_parent().get_node("Cientist_Portrait")
	portrait.start_talking()
	
func _text_tween_complete( object, key ):
	var portrait = get_parent().get_node("Cientist_Portrait")
	portrait.stop_talking()
	start_deactivate_timer()
	
func start_deactivate_timer():
	print("ending")
	var timer = get_node("Deactivate Timer")
	timer.start()

