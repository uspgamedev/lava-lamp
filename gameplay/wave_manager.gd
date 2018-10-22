extends Node

const ENEMIES = [ # 12 enemies
#	['Eye', 'res://characters/enemies/olhinho', 2,                  'A little floating eye.', 4],
	['Shielded', 'res://characters/enemies/shielded', 5,            "It thinks it's a knight.", 4],
#	['Charger', 'res://characters/enemies/charger', 7,              "It has little kids for breakfast. Now it can't have breakfast anymore.", 4],
#	['Ghost', 'res://characters/enemies/ghost', 12,                 "It's a ghost and a robot. Don't ask me.", 3],
#	['Mage', 'res://characters/enemies/mage', 15,                   'A little eye that shoots bullets.', 3],
#	['Bouncer', 'res://characters/enemies/bouncer', 20,             "It's capable of doing 1 homerun for every 5 swings.", 4],
#	['Undead', 'res://characters/enemies/undead', 25,               "It's a zombie and a robot. Don't.", 16],
#	['Absorber', 'res://characters/enemies/absorber', 30,           'You figure out what it does.', 4],
#	['Hard Bouncer', 'res://characters/enemies/hard_bouncer', 45,   "It's capable of doing 5 homeruns for every 1 swing.", 10],
#	['Hard Mage', 'res://characters/enemies/hard_mage', 55,         'A little eye that shoots bullets and teleports.', 5],
#	['Hard Charger', 'res://characters/enemies/hard_charger', 65,   'Your greatest nightmare. Good luck.', 6],
#	['Hard Shielded', 'res://characters/enemies/hard_shielded', 77, "It thinks it's a paladin.", 6]
]

const MECHANICS = [ # 17 mechanics
	['Simple Bullet', 'create_simple_bullet',     "It's simple. Do you want to know more? What part of simple did you not understand?"],
	['Trap', 'create_trap',                       "It goes off if an enemy goes over it. Of course they have to step on it first. *Giggle*"],
	['Tracer Bullet', 'create_tracer_bullet',     "If you make a hole in my wall I'll make sure you regret it."],
	['Dash', 'dash',                              "Dash!"],
	['Ghost Bullet', 'create_ghost_bullet',       'They used to say its scream sound comes from a test subject of an old evil experiment.'],
	['Wormhole', 'create_wormhole',               "A wormhole, it probably won't reduce your sanity."],
	['Armor', 'shield',                           "Won't protect you for long, don't rely too much on it."],
	['Ion Bullet', 'create_ion_bullet',           "It fries these damn robots circuits for a little time. It has a very different effect on organic lifeforms. Good old \n times.                                         "],
	['Cure Bullet', 'create_cure_bullet',         "You're the last of the LAVA series LAMP edition. And you want to HEAL your enemies??"],
	['Guided Bullet', 'create_guided_bullet',     "Are you that lazy that you can't even bother to target the damn enemy?"],
	['Shotgun', 'create_shotgun_bullet',          "The good old shotgun. It reloads automatically and it's probably the last of it's kind."],
	['Ricochet Bullet', 'create_ricochet_bullet', "A hardcore way to play pong."],
	['Storm', 'create_earthquake',                "You're part of the goddamn LAVA series, do you really need an upgrade to do a little Storm?"],
	['Charge Bullet', 'create_charge_bullet',     "Do you wanna be a megaman fanboy or something? Goddamn LAMPs these days."],
	['Laser', 'create_laser',                     "Light amplified by Anti A.T. Field until it becomes a deadly energy beam. Cats love them for some reason."],
	['Flamethrower', 'create_flamethrower',       "Try to not break it. I want to roast some marshmallows later."],
	['Double Bullet', 'create_double_bullet',     "The ultimate weapon. All science has converged to this. You are lucky to be alive and witness this."],
]

const END_SPEECHES = [
	'That was easy!',
	'You did it! I just can\'t believe...',
	'May today\'s success be the beginning of tomorrow\'s achievements.',
	'I knew the record would stand until it was broken.',
	'The biggest reward for a thing well done is to have done it.',
	'The fruit of your labor is sweet, and I must say you deserve it.',
	'That was a massacre!',
	'HAHA! It was so much fun watching you running away from them!',
	"Disappointed but not surprised.",
	"This is useless, we're all going to die anyway...",
	"I told them the LAMP edition would be awesome.",
	"Damn, that was close.",
	"Live and let live.",
]

const START_SPEECHES = [
	'New wave incoming! Get ready for it!',
	'This will be a tough one! I hope you\'re prepared.',
	'DESTROY THEM ALL!!!',
	'You see it? They are coming to get you!',
	'Prepare for war!',
	'Get ready for the next battle!',
	"You have no idea what's coming next.",
	"Let's see what you're capable of.",
	"I loved my mother so much... now you must [color=red]avenge[/color] her!",
	"Is there any point in going forward? Well, let's do it.",
	"This is meaningless. Just do it.",
	"This is what we were born to do. You and me, together, fighting these bastards.",
	"I thought I saw someone in the lab the other day...",
	"Hum? I just heard someone... Forget it, now I'm alone in here.",
	"It's dangerous to go alone. Take this.",
]

const NEW_ENEMY_TYPE = 3
const NEW_MECH_TYPE = 2
const NEW_ENEMY_PROPORTION = float(1)/3

var reserved_keys = [ 
KEY_W, KEY_A, KEY_S, KEY_D, KEY_ESCAPE, KEY_TAB, KEY_LEFT, KEY_UP, KEY_RIGHT, \
KEY_DOWN, BUTTON_LEFT, KEY_ALT, KEY_SUPER_L
]

var cur_wave = 1
var wave_points = 10
var key
var waiting_key = false
var cur_mechanics = -1
var cur_enemy = -1
var t
var HealthPack = preload('res://scenario/props/health_pack.tscn')

signal change_emotion(emotion, time)

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node('Player_Portrait')
onready var dialog_box = gui.get_node('Dialog Box')
onready var bgm = get_node('../BGM')

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	t = Timer.new()
	t.set_wait_time(3)
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	add_child(t)
	var game_mode = get_node('/root/game_mode')
	if (game_mode.mode == game_mode.SURVIVAL):
		wave_points = 100
		cur_mechanics = 16
		cur_enemy = 11
		var ah = get_node('../Props/Player').get_node('ActionHandler')
		ah.set_key_to_action(BUTTON_RIGHT,      MECHANICS[0][1])  # Simple Bullet
		ah.set_key_to_action(KEY_CONTROL,       MECHANICS[1][1])  # Trap
		ah.set_key_to_action(KEY_1,             MECHANICS[2][1])  # Tracer Bullet
		ah.set_key_to_action(KEY_SPACE,         MECHANICS[3][1])  # Dash             Animação quebrada
		ah.set_key_to_action(BUTTON_WHEEL_UP,   MECHANICS[4][1])  # Ghost Bullet
		ah.set_key_to_action(KEY_P,             MECHANICS[5][1])  # Wormhole
		ah.set_key_to_action(KEY_SHIFT,         MECHANICS[6][1])  # Armor            Animação quebrada
		ah.set_key_to_action(BUTTON_WHEEL_DOWN, MECHANICS[7][1])  # Ion Bullet
		ah.set_key_to_action(BUTTON_MIDDLE,     MECHANICS[8][1])  # Cure Bullet
		ah.set_key_to_action(KEY_2,             MECHANICS[9][1])  # Guided Bullet
		ah.set_key_to_action(KEY_3,             MECHANICS[10][1]) # Shotgun
		ah.set_key_to_action(KEY_Q,             MECHANICS[11][1]) # Ricochet Bullet
		ah.set_key_to_action(KEY_CAPSLOCK,      MECHANICS[12][1]) # Storm            Animação quebrada
		ah.set_key_to_action(KEY_4,             MECHANICS[13][1]) # Charge Bullet    Animação quebrada
		ah.set_key_to_action(KEY_E,             MECHANICS[14][1]) # Laser
		ah.set_key_to_action(KEY_F,             MECHANICS[15][1]) # Flamethrower     Animação quebrada
		ah.set_key_to_action(KEY_L,             MECHANICS[16][1]) # Double Bullet
		
		ah.set_used_key(BUTTON_RIGHT)
		ah.set_used_key(KEY_CONTROL)
		ah.set_used_key(KEY_1)
		ah.set_used_key(KEY_SPACE)
		ah.set_used_key(BUTTON_WHEEL_UP)
		ah.set_used_key(KEY_P)
		ah.set_used_key(KEY_SHIFT)
		ah.set_used_key(BUTTON_WHEEL_DOWN)
		ah.set_used_key(BUTTON_MIDDLE)
		ah.set_used_key(KEY_2)
		ah.set_used_key(KEY_3)
		ah.set_used_key(KEY_Q)
		ah.set_used_key(KEY_CAPSLOCK)
		ah.set_used_key(KEY_4)
		ah.set_used_key(KEY_E)
		ah.set_used_key(KEY_F)
		ah.set_used_key(KEY_L)

func update_wave_points():
	wave_points += cur_wave
	print('Next wave: ', cur_wave, '; Points: ', wave_points)

func wave_ended():
	var lives = randi() % 3
	var text = END_SPEECHES[randi()%END_SPEECHES.size()]
	var wait_time = 4
	if lives > 0:
		text += " I left %d [color=lime]health pack%s[/color] for you as a reward. Go search for %s." % [lives, "s" if lives > 1 else "", "them" if lives > 1 else "it"]
		wait_time += 3
	var main = get_node('/root/Main')
	for i in range(lives):
		var p = main.get_valid_position()
		var hp = HealthPack.instance()
		hp.set_position(p)
		main.get_node('Props').add_child(hp)

	dialog_box.display_text(text, wait_time)
	print('Wave ', cur_wave, ' ended')
	bgm._interlude_mode()
	emit_signal('change_emotion', "happy", 3)
	cur_wave += 1
	update_wave_points()
	t.set_wait_time(wait_time)
	t.disconnect('timeout', self, 'start_wave')
	t.connect('timeout', self, 'new_wave')
	t.set_one_shot(true)
	t.start()

func _input(ev):
	if (ev is InputEventMouseButton):
		key = ev.button_index
	elif (ev is InputEventKey):
		key = ev.scancode
	else: return
	for i in reserved_keys:
		if key == i:
			return
	set_process_input(false)
	waiting_key = false

func give_new_mechanics():
	cur_mechanics += 1
	dialog_box.display_new_ability(MECHANICS[cur_mechanics][0], MECHANICS[cur_mechanics][2], load("res://actions/" + MECHANICS[cur_mechanics][1] + ".gd").new().icon.instance())
	get_new_mechanics_input()

func get_new_mechanics_input():
	dialog_box.display_text("Press a button to assign the input for " + MECHANICS[cur_mechanics][0] + '.', 10e+10)
	set_process_input(true)
	var player = get_node('../Props/Player')
	var ah = player.get_node('ActionHandler')
	player.stop_movimentation()
	waiting_key = true
	while(waiting_key):
		yield(get_tree(), 'physics_frame')
	ah.set_key_to_action(key, MECHANICS[cur_mechanics][1])
	ah.set_used_key(key)
	reserved_keys.append(key)
	player.resume_movimentation()
	dialog_box.display_text("To use " + MECHANICS[cur_mechanics][0] + ", press " + get_node("/root/input").get_key_string(key) + '.', 3)
	prepare_wave(false)

func start_wave():
	dialog_box.display_text(START_SPEECHES[randi()%START_SPEECHES.size()], 5)
	var w = get_node('Wave')
	dialog_box.clear_all_info_boxes()
	print('Wave ', cur_wave, ' started')
	get_node('/root/Main/GUI/WaveCount').set_text("Wave %d" % cur_wave)
	bgm._action_mode()
	w.start()

func prepare_wave(only_new_enemy):
	var time = 3
	if (only_new_enemy):
		time += 3
		var timer = dialog_box.get_node("Deactivate Timer")
		timer.stop()
		dialog_box.text_tween.stop_all()
	var w = get_node('Wave')
	t.set_wait_time(time)
	t.disconnect('timeout', self, 'new_wave')
	t.connect('timeout', self, 'start_wave')
	t.set_one_shot(true)
	t.start()
	w.connect('ended', self, 'wave_ended')

func introduce_enemy_type():
	cur_enemy += 1
	print (ENEMIES[cur_enemy])
	dialog_box.display_new_enemy(ENEMIES[cur_enemy][0], var2str(ENEMIES[cur_enemy][4]), ENEMIES[cur_enemy][3], load(ENEMIES[cur_enemy][1] + '_icon.tscn').instance())
	
func new_wave():
	var only_new_enemy = false
	if (cur_wave % NEW_ENEMY_TYPE == 1) and (cur_enemy < (ENEMIES.size() - 1)):
		introduce_enemy_type()
		only_new_enemy = true
	if (cur_wave % NEW_MECH_TYPE == 1) and (cur_mechanics < (MECHANICS.size() - 1)):
		only_new_enemy = false
		give_new_mechanics()
	else:
		prepare_wave(only_new_enemy)

