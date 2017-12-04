extends 'res://characters/body.gd'

const DIR = preload('res://characters/player/input/directions.gd')

onready var input = get_node('/root/input')
onready var camera = get_node('Camera')
onready var ah = get_node('ActionHandler')
onready var sfx = get_node('SFX')
onready var afterimage = get_node('AfterImage')
onready var sprite = get_node('Sprite')
onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node("Player_Portrait")
onready var dialog_box = gui.get_node("Dialog Box")
onready var shoot_timer = get_node("Shooting_Timer")
onready var shooting = false
onready var spinning = false
onready var can_skip = false
onready var can_complete = false

#Possible doctor's first name
const FIRST_NAMES = [
	"Boris",
	"Vladimir",
	"Dimitri",
	"Ygor",
	"Ivan",
	"Mikhail",
	"Sergei",
	"Vladslav",
	"Viktor",
]

#Possible doctor's self chosen name and reason
const DR_NAMES_AND_REASONS = [
	["Phoenix", "because I rose from the ashes like a beautiful birb."],
	["Yggdrasil", "because I am the Tree of Life in our forgotten realm."],
]

signal change_emotion(emotion, time)
signal look_dir_changed(dir)

var dir = 2
var intro_func

func _ready():
	set_fixed_process(true)
	unlock_controls()
	input.connect('skip_intro', self, 'skip_intro')

	self.connect('change_emotion', portrait, 'change_emotion')

	ah.set_key_to_action(KEY_Q, 'create_simple_bullet')
	ah.set_key_to_action(KEY_C, 'create_trap')

	load_camera()

	intro_func = intro()

func delayed_reload():
	for i in range(30):
		yield(get_tree(), "fixed_frame")
	sfx.play("Reload")

func stop_movimentation():
	input.disconnect('hold_direction', self, '_add_speed')
	input.disconnect('hold_direction', self, '_set_look_dir')
	input.disconnect('hold_look', self, '_set_look_dir')
	input.disconnect('press_action', self, '_act')
	input.disconnect('skip_intro', self, 'skip_intro')

func resume_movimentation():
	input.connect('hold_direction', self, '_add_speed')
	input.connect('hold_direction', self, '_set_look_dir')
	input.connect('hold_look', self, '_set_look_dir')
	input.connect('press_action', self, '_act')
	input.connect('skip_intro', self, 'skip_intro')

func get_look_vec():
	return get_look_dir()

func _set_look_dir(dir):
	if dir != -1:
		self.dir = dir
		emit_signal("look_dir_changed", dir)

func dash(time):
	self.dashTime = time
	sfx.play('Dash')
	var frame = sprite.get_frame() * 1.0 / (sprite.get_hframes() * sprite.get_vframes())
	afterimage.set_param(Particles2D.PARAM_ANIM_INITIAL_POS, frame)
	afterimage.set_emitting(true)

func shield(time):
	self.shieldTime = time
	get_node("Shielded").set_hidden(false)
	get_node("Shielded/Timer").start()
	get_node("Shielded/Particles2D").set_emitting(true)

func get_look_dir():
	if input.control_type == input.MOUSE:
		return (get_viewport().get_mouse_pos() - get_global_transform_with_canvas().o).normalized()
	else:
		return DIR.VECTOR[self.dir]

func get_look_dir_value():
	return self.dir

func start_shooting():
	shooting = true
	if not shoot_timer.is_active():
		shoot_timer.stop()
	shoot_timer.start()

func stop_shooting():
	shooting = false

func is_shooting():
	return shooting

func start_spinning():
	spinning = true

func stop_spinning():
	spinning = false

func is_spinning():
	return spinning

func load_camera():
	camera.set_enable_follow_smoothing(true)
	camera.set_follow_smoothing(5)
	camera.make_current()

func _stun():
	lock_controls()
	get_node("Stunned").set_hidden(false)
	get_node("StunTimer").start()
	get_node("Stunned/Timer").start()

func _unstun():
	unlock_controls()

func deal_damage(d):
	if (self.shieldTime == 0):
		self.damage = max(0, self.damage + d)
	self.get_node("Sprite/Hit").play("hit")
	if self.damage >= self.hp:
		get_tree().change_scene('res://main.tscn')
	gui.get_node('HealthBar').update()
	if d > 0:
		emit_signal('change_emotion', "angry", 2)
	elif d < 0:
		emit_signal('change_emotion', 'happy', 2)

func _on_Expression_Timer_timeout():
	emit_signal('change_emotion', "normal")

func lock_controls():
	input.disconnect('hold_direction', self, '_add_speed')
	input.disconnect('hold_direction', self, '_set_look_dir')
	input.disconnect('hold_look', self, '_set_look_dir')
	input.disconnect('press_action', ah, 'do_selected_action')
	ah.set_process_unhandled_key_input(false)
	get_node("Hook").hide()

func unlock_controls():
	input.connect('hold_direction', self, '_add_speed')
	input.connect('hold_direction', self, '_set_look_dir')
	input.connect('hold_look', self, '_set_look_dir')
	input.connect('press_action', ah, 'do_selected_action')
	ah.set_process_unhandled_key_input(true)
	get_node("Hook").show()

func _on_Intro_Tween_tween_complete( object, key ):
	intro_func = intro_func.resume()

func _on_Intro_Timer_timeout():
	intro_func = intro_func.resume()

func get_first_name():
	randomize()
	return FIRST_NAMES[randi()%FIRST_NAMES.size()]

func get_doctor_name():
	randomize()
	return DR_NAMES_AND_REASONS[randi()%DR_NAMES_AND_REASONS.size()]

func skip_intro():
	var logo = gui.get_node("Logo")
	if logo.is_logo_active():
		can_skip = true
		can_complete = false
	if can_complete:
		can_complete = false
		can_skip = true
		dialog_box.text_tween.set_speed(500)
		return
	if can_skip:
		can_skip = false
		can_complete = true
		dialog_box.text_tween.set_speed(1)
		if dialog_box.is_active():
			dialog_box.deactivate_box()

		var logo = gui.get_node("Logo")
		if logo.is_logo_active():
			logo.stop_logo_animation()

		var timer = get_node("Intro_Timer")
		if timer.is_active():
			timer.stop()
			_on_Intro_Timer_timeout()
			return

		var tween = get_node("Intro_Tween")
		if tween.is_active():
			tween.stop_all()
			_on_Intro_Tween_tween_complete(null, null)
			return



func intro():
	lock_controls()
	start_spinning()
	var tween = get_node("Intro_Tween")
	tween.interpolate_property(get_node("Sprite"), "offset", Vector2(0,-200), Vector2(0,0), 2.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield()

	stop_spinning()
	can_complete = true
	var first_name = get_first_name()
	var arg = get_doctor_name()
	var dr_name = arg[0]
	var reason = arg[1]
	dialog_box.display_text("Welcome, my beloved [color=lime]creation[/color]! My name is [color=#f442b9]"+first_name+"[/color], but you can call me [color=yellow]Dr. "+dr_name+"[/color], "+reason, 5)
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(9)
	timer.start()

	yield()

	dialog_box.display_text("Yet none of this matters now. Our world as we know it has become [color=black]APOCALYPTIC!!![/color] And [color=lime]you[/color] are our last hope to save humankind! And who are [color=lime]you[/color], you may ask? Well you are the [color=#6be51b]one[/color] and [color=#6be51b]only[/color]...", 5)
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(12)
	timer.start()

	yield()

	dialog_box.display_text("[center][color=yellow]L[/color][color=lime]egendary[/color] [color=yellow]A[/color][color=lime]utonamous[/color] [color=yellow]V[/color][color=lime]ersatile[/color] [color=yellow]A[/color][color=lime]ndroid[/color] [color=black]series[/color][/center] [center][color=yellow]L[/color][color=lime]atest-generation[/color] [color=yellow]A[/color][color=lime]nti-apocalyptic[/color] [color=yellow]M[/color][color=lime]oddable[/color] [color=yellow]P[/color][color=lime]rototype[/color] [color=black]edition![/color][fill] [/fill][/center]", 5)
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(10)
	timer.start()

	yield()

	gui.get_node("Logo").start_logo_animation()
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(6)
	timer.start()

	yield()

	can_complete = false
	unlock_controls()

	var timer = get_node("Intro_Timer")
	timer.set_wait_time(2)
	timer.start()

	yield()

	#Start first wave
	get_node('/root/Main/WaveManager').new_wave()
