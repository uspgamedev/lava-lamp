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
	'create_double_bullet',
	'create_shotgun_bullet',
	'create_ricochet_bullet',
	'dash',
	'create_trap',
	'create_charge_bullet',
	'create_tracer_bullet',
	'create_flamethrower',
	'create_wormhole',
	'create_guided_bullet',
	'create_earthquake',
	'create_ion_bullet',
	'create_laser',
	'create_ghost_bullet',
	'create_cure_bullet'
]

const END_SPEECHES = [
	'That was easy!',
	'You did it! I just can\'t believe...',
	'May today\'s success be the beginning of tomorrow\'s achievements.',
	'I knew the record would stand until it was broken.',
	'The biggest reward for a thing well done is to have done it.',
	'The fruit of your labor is sweet, and I must say you deserve it.',
	'That was a massacre!',
	'HAHA! It was so much fun watching you running away from them!'
]

const START_SPEECHES = [
	'New wave incoming! Get ready for it!',
	'This will be a tough one! I hope you\'re prepared.',
	'DESTROY THEM ALL!!!',
	'You see it? They are coming to get you!',
	'Prepare for war!',
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
onready var bgm = get_node('../BGM')

func update_enemy_types():
	if (cur_wave%NEW_ENEMY_TYPE == 0 and enemy_types < ENEMIES.size()):
		enemy_types += 1

func update_wave_points():
	wave_points += cur_wave*3
	print(cur_wave, ' wave points ', wave_points)

var HealthPack = preload('res://scenario/props/health_pack.tscn')

func wave_ended():
	var lives = randi() % 3
	var text = END_SPEECHES[randi()%END_SPEECHES.size()]
	if lives > 0: text += " I left %d health pack%s for you as a reward. Go search for them." % [lives, "s" if lives > 1 else ""]
	var main = get_node('/root/Main')
	for i in range(lives):
		var p = main.get_valid_position()
		var hp = HealthPack.instance()
		hp.set_pos(p)
		main.get_node('Props').add_child(hp)

	dialog_box.display_text(text, 6)
	print('Wave ', cur_wave, ' ended')
	bgm._interlude_mode()
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	update_enemy_types()
	update_wave_points()
	t.set_wait_time(6)
	t.disconnect('timeout', self, 'start_wave')
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	t.start()

func _unhandled_key_input(ev):
	key = ev.scancode
	if (key >= KEY_0 and key <= KEY_9) or (key >= KEY_A and key <= KEY_Z):
		for i in reserved_keys:
			if key == i:
				return
		waiting_key = false

func give_new_mechanics():
	dialog_box.display_text("Press a button to assign your new awesome ability!", 10e+10)
	dialog_box.display_new_ability("DUMMY", "Makes you even more stupid!", load("res://actions/create_trap.gd").new().icon.instance())
	dialog_box.display_new_enemy("BAD GUY", "3", "Strong enemy that hits you. Is immune to [color=yellow]traps[/color].", preload("res://actions/dash.gd").new().icon.instance())
	set_process_unhandled_key_input(true)
	var player = get_node('../Props/Player')
	var ah = player.get_node('ActionHandler')
	player.stop_movimentation()
	waiting_key = true
	while(waiting_key):
		yield(get_tree(), 'fixed_frame')
	ah.set_key_to_action(key, MECHANICS[cur_mechanics])
	cur_mechanics += 1
	reserved_keys.append(key)
	player.resume_movimentation()
	set_process_unhandled_key_input(false)
	dialog_box.display_text("To use your new ability, press " + OS.get_scancode_string(key), 6)
	prepare_wave()

func start_wave():
	dialog_box.display_text(START_SPEECHES[randi()%START_SPEECHES.size()], 6)
	var w = get_node('Wave')
	dialog_box.clear_all_info_boxes()
	print('Wave ', cur_wave, ' started')
	bgm._action_mode()
	w.start()

func prepare_wave():
	var w = get_node('Wave')
	t.set_wait_time(3)
	t.disconnect('timeout', self, 'new_wave')
	t.connect('timeout', self, 'start_wave')
	t.set_one_shot(true)
	t.start()
	w.connect('ended', self, 'wave_ended')

func new_wave():
	if (cur_wave%NEW_ENEMY_TYPE == 0):
		give_new_mechanics()
	else:
		prepare_wave()

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	t = Timer.new()
	t.set_wait_time(5)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	add_child(t)
