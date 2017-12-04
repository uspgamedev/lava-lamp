extends Node

const ENEMIES = [ # 12 enemies
	['Olhinho', preload('res://characters/enemies/olhinho.tscn'), 2,              'DESCRIÇÃO', 4],
	['Charger', preload('res://characters/enemies/charger.tscn'), 5,              'DESCRIÇÃO', 4],
	['Shielded', preload('res://characters/enemies/shielded.tscn'), 7,            'DESCRIÇÃO', 4],
	['Mage', preload('res://characters/enemies/mage.tscn'), 12,                   'DESCRIÇÃO', 3],
	['Bouncer', preload('res://characters/enemies/bouncer.tscn'), 15,             'DESCRIÇÃO', 4],
	['Ghost', preload('res://characters/enemies/ghost.tscn'), 20,                 'DESCRIÇÃO', 4],
	['Absorber', preload('res://characters/enemies/absorber.tscn'), 25,           'DESCRIÇÃO', 4],
	['Undead', preload('res://characters/enemies/undead.tscn'), 30,               'DESCRIÇÃO', 16],
	['Hard Shielded', preload('res://characters/enemies/hard_shielded.tscn'), 45, 'DESCRIÇÃO', 6],
	['Hard Bouncer', preload('res://characters/enemies/hard_bouncer.tscn'), 55,   'DESCRIÇÃO', 10],
	['Hard Mage', preload('res://characters/enemies/hard_mage.tscn'), 65,         'DESCRIÇÃO', 5],
	['Hard Charger', preload('res://characters/enemies/hard_charger.tscn'), 77,   'DESCRIÇÃO', 6]
]

const MECHANICS = [ # 17 mechanics
	['Simple Bullet', 'create_simple_bullet',     'DESCRIÇÃO'],
	['Double Bullet', 'create_double_bullet',     'DESCRIÇÃO'],
	['Shotgun', 'create_shotgun_bullet',          'DESCRIÇÃO'],
	['Ricochet Bullet', 'create_ricochet_bullet', 'DESCRIÇÃO'],
	['Dash', 'dash',                              'DESCRIÇÃO'],
	['Trap', 'create_trap',                       'DESCRIÇÃO'],
	['Charge Bullet', 'create_charge_bullet',     'DESCRIÇÃO'],
	['Tracer Bullet', 'create_tracer_bullet',     'DESCRIÇÃO'],
	['Flamethrower', 'create_flamethrower',       'DESCRIÇÃO'],
	['Wormhole', 'create_wormhole',               'DESCRIÇÃO'],
	['Guided Bullet', 'create_guided_bullet',     'DESCRIÇÃO'],
	['Storm', 'create_earthquake',                'DESCRIÇÃO'],
	['Ion Bullet', 'create_ion_bullet',           'DESCRIÇÃO'],
	['Laser', 'create_laser',                     'DESCRIÇÃO'],
	['Ghost Bullet', 'create_ghost_bullet',       'DESCRIÇÃO'],
	['Cure Bullet', 'create_cure_bullet',         'DESCRIÇÃO'],
	['Armor', 'shield',                           'DESCRIÇÃO']
]

const DOUBLE_MECH_WAVES = [
	
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

const NEW_ENEMY_TYPE = 1
const NEW_ENEMY_PROPORTION = 1/3

var reserved_keys = [ KEY_W, KEY_A, KEY_S, KEY_D, KEY_Q ]

var cur_wave = 1
var enemy_types = 1
var wave_points = 10
var key
var waiting_key = false
var cur_mechanics = 1

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
	var wait_time = 6
	if lives > 0:
		text += " I left %d health pack%s for you as a reward. Go search for them." % [lives, "s" if lives > 1 else ""]
		wait_time += 4
	var main = get_node('/root/Main')
	for i in range(lives):
		var p = main.get_valid_position()
		var hp = HealthPack.instance()
		hp.set_pos(p)
		main.get_node('Props').add_child(hp)

	dialog_box.display_text(text, wait_time)
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
	dialog_box.display_new_ability(MECHANICS[cur_mechanics][0], MECHANICS[cur_mechanics][2], load("res://actions/" + MECHANICS[cur_mechanics][1] + ".gd").new().icon.instance())
	dialog_box.display_new_enemy(ENEMIES[cur_mechanics][0], var2str(ENEMIES[cur_mechanics][4]), ENEMIES[cur_mechanics][3], load("res://actions/dash.gd").new().icon.instance())
	for i in DOUBLE_MECH_WAVES:
		if i == cur_wave:
			dialog_box.display_new_ability(MECHANICS[cur_mechanics + 1][0], MECHANICS[cur_mechanics + 1][2], load("res://actions/" + MECHANICS[cur_mechanics + 1][1] + ".gd").new().icon.instance())
			get_new_mechanics_input(true)
			return
	get_new_mechanics_input(false)

func get_new_mechanics_input(double_mech):
	dialog_box.display_text("Press a button to assign the input for " + MECHANICS[cur_mechanics][0] + '.', 10e+10)
	set_process_unhandled_key_input(true)
	var player = get_node('../Props/Player')
	var ah = player.get_node('ActionHandler')
	player.stop_movimentation()
	waiting_key = true
	while(waiting_key):
		yield(get_tree(), 'fixed_frame')
	ah.set_key_to_action(key, MECHANICS[cur_mechanics][1])
	reserved_keys.append(key)
	player.resume_movimentation()
	set_process_unhandled_key_input(false)
	dialog_box.display_text("To use " + MECHANICS[cur_mechanics][0] + ", press " + OS.get_scancode_string(key) + '.', 4)
	cur_mechanics += 1
	if (double_mech):
		var timer = Timer.new()
		timer.set_wait_time(4)
		timer.set_one_shot(true)
		timer.start()
		add_child(timer)
		yield(timer, 'timeout')
		get_new_mechanics_input(false)
	else:
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
