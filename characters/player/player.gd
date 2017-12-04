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
	input.connect('hold_direction', self, '_add_speed')
	input.connect('hold_direction', self, '_set_look_dir')
	input.connect('press_action', self, '_act')
	#input.connect('hold_look', self, '_set_look_dir')

	self.connect('change_emotion', portrait, 'change_emotion')

	ah.set_key_to_action(KEY_B, 'debug')
	ah.set_key_to_action(KEY_G, 'create_simple_bullet')
	ah.set_key_to_action(KEY_N, 'create_trap')
	ah.set_key_to_action(KEY_M, 'create_wormhole')
	ah.set_key_to_action(KEY_F, 'create_ricochet_bullet')
	ah.set_key_to_action(KEY_V, 'dash')
	ah.set_key_to_action(KEY_H, 'create_double_bullet')
	ah.set_key_to_action(KEY_J, 'create_tracer_bullet')
	ah.set_key_to_action(KEY_K, 'create_guided_bullet')
	ah.set_key_to_action(KEY_R, 'create_charge_bullet')
	ah.set_key_to_action(KEY_T, 'create_shotgun_bullet')
	ah.set_key_to_action(KEY_U, 'create_earthquake')
	ah.set_key_to_action(KEY_Y, 'create_ion_bullet')
	ah.set_key_to_action(KEY_C, 'create_flamethrower')
	ah.set_key_to_action(KEY_X, 'create_laser')
	ah.set_key_to_action(KEY_O, 'create_ghost_bullet')
	ah.set_key_to_action(KEY_L, 'create_cure_bullet')

	load_camera()
	
	intro_func = intro()

func get_look_vec():
	return DIR.VECTOR[self.dir]

func _set_look_dir(dir):
	if not Input.is_action_pressed("lock_dir"):
		self.dir = dir
		emit_signal("look_dir_changed", dir)

func dash(time):
	self.dashTime = time
	sfx.play('Dash')
	var frame = sprite.get_frame() * 1.0 / (sprite.get_hframes() * sprite.get_vframes())
	afterimage.set_param(Particles2D.PARAM_ANIM_INITIAL_POS, frame)
	afterimage.set_emitting(true)

func get_look_dir():
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
	input.disconnect('press_action', self, '_act')
	ah.capturing = false
	get_node("Hook").hide()

func unlock_controls():
	input.connect('hold_direction', self, '_add_speed')
	input.connect('hold_direction', self, '_set_look_dir')
	input.connect('press_action', self, '_act')
	ah.capturing = true
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

func intro():
	lock_controls()
	start_spinning()
	var tween = get_node("Intro_Tween")
	tween.interpolate_property(get_node("Sprite"), "offset", Vector2(0,-200), Vector2(0,0), 2.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	yield()
	
	stop_spinning()
	can_skip = true
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
	
	dialog_box.display_text("[center][color=yellow]L[/color][color=lime]egendary[/color] [color=yellow]A[/color][color=lime]utonamous[/color] [color=yellow]V[/color][color=lime]ersatile[/color] [color=yellow]A[/color][color=lime]ndroid[/color] [color=black]series[/color][fill] [/fill][/center] [center][color=yellow]L[/color][color=lime]atest-generation[/color] [color=yellow]A[/color][color=lime]nti-apocalyptic[/color] [color=yellow]M[/color][color=lime]oddable[/color] [color=yellow]P[/color][color=lime]rototype[/color] [color=black]edition![/color][fill] [/fill][/center]", 5)
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(10)
	timer.start()
	
	yield()
	
	can_skip = false
	unlock_controls()
	
	var timer = get_node("Intro_Timer")
	timer.set_wait_time(5)
	timer.start()
	
	yield()
	
	
