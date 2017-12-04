extends Node

const ENEMIES = [
	preload('res://characters/enemies/olhinho.tscn'),
	preload('res://characters/enemies/charger.tscn'),
	preload('res://characters/enemies/shielded.tscn'),
	preload('res://characters/enemies/mage.tscn'),
	preload('res://characters/enemies/bouncer.tscn'),
	preload('res://characters/enemies/ghost.tscn'),
	preload('res://characters/enemies/absorber.tscn'),
	preload('res://characters/enemies/undead.tscn'),
	preload('res://characters/enemies/hard_shielded.tscn'),
	preload('res://characters/enemies/hard_bouncer.tscn'),
	preload('res://characters/enemies/hard_mage.tscn'),
	preload('res://characters/enemies/hard_charger.tscn'),
]

const ENEMY_POINTS = [
	2, #olhinho
	5, #charger
	7, #shielded
	12, #mage
	15, #bouncer
	20, #ghost
	25, #absorber
	30, #undead
	45, #hard shielded
	55, #hard bouncer
	65, #hard mage
	77, #hard charger
]

const MECHANICS = [
	'create_shotgun_bullet',
	'create_wormhole',
	'create_ricochet_bullet',
	'dash',
	'create_double_bullet',
	'create_tracer_bullet',
	'create_guided_bullet',
	'create_charge_bullet',
	'create_shotgun_bullet',
	'create_earthquake',
	'create_ion_bullet',
	'create_flamethrower',
	'create_laser',
	'create_ghost_bullet',
	'create_cure_bullet'
]

const NEW_ENEMY_TYPE = 3
const NEW_ENEMY_PROPORTION = 1/3

var reserved_keys = [ KEY_W, KEY_A, KEY_S, KEY_D, KEY_Q ]

var cur_wave = 1
var enemy_types = 1
var wave_points = 10
var key
var waiting_key = false
var cur_mechanics = 0

var t

signal change_emotion(emotion, time)

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node('Player_Portrait')
onready var dialog_box = gui.get_node('Dialog Box')

func update_enemy_types():
	if (cur_wave%NEW_ENEMY_TYPE == 0 and enemy_types < ENEMIES.size()):
		enemy_types += 1

func update_wave_points():
	wave_points += cur_wave*3
	print(cur_wave, ' wave points ', wave_points)

func wave_ended():
	print('Wave ', cur_wave, ' ended')
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	update_enemy_types()
	update_wave_points()
	t.start()

func _unhandled_key_input(ev):
	key = ev.scancode
	if (key >= 48 and key <= 57) or (key >= 65 and key <= 90):
		for i in reserved_keys:
			if key == i:
				return
		waiting_key = false

func give_new_mechanics():
	#if (cur_wave%NEW_ENEMY_TYPE == 0):
	if (true):
		dialog_box.display_text("Press a button to assign your new awesome ability!", 6)
		set_process_unhandled_key_input(true)
		var player = get_node('../Props/Player')
		var ah = player.get_node('ActionHandler')
		player.stop_movimentation()
		waiting_key = true
		while(waiting_key):
			yield(get_tree(), 'fixed_frame')
		ah.set_key_to_action(key, MECHANICS[cur_mechanics])
		print(key)
		cur_mechanics += 0
		reserved_keys.append(key)
		player.resume_movimentation()
		set_process_unhandled_key_input(false)
	dialog_box.display_text("New wave incoming [color=purple]baby!![/color] Also this is a [color=blue]long[/color] [color=red]long[/color] [color=green]long[/color] long long long long long long long long long long long long text haha", 6)
	t = Timer.new()
	t.set_wait_time(10)
	t.connect('timeout', self, 'start_wave')
	t.start()
	t.set_one_shot(true)
	add_child(t)

func start_wave():
	var w = get_node('Wave')
	print('Wave ', cur_wave, ' started')
	w.start()

func new_wave():
	var w = get_node('Wave')
	give_new_mechanics()
	dialog_box.display_new_ability("DUMMY", "K", "Makes you even more stupid!", preload("res://actions/create_trap.gd").new().icon.instance())
	dialog_box.display_new_enemy("BAD GUY", "3", "Strong enemy that hits you. Is immune to [color=yellow]traps[/color].", preload("res://actions/dash.gd").new().icon.instance())
	dialog_box.display_new_ability("CRAZY THING", "R", "Omar is underrated! Omar is underrated! Omar is underrated! Omar is underrated!", preload("res://actions/create_shotgun_bullet.gd").new().icon.instance())
	w.connect('ended', self, 'wave_ended')

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	t = Timer.new()
	t.set_wait_time(5)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	add_child(t)
