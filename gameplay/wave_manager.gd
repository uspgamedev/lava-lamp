extends Node

const ENEMIES = [ # 12 enemies
	['Olhinho', 'res://characters/enemies/olhinho', 2,              'A little floating eye.', 4],
	['Shielded', 'res://characters/enemies/shielded', 5,            "It thinks it's a knight.", 4],
	['Charger', 'res://characters/enemies/charger', 7,              "It has little kids for breakfast. Now it can't have breakfast anymore.", 4],
	['Ghost', 'res://characters/enemies/ghost', 12,                 "It's a ghost and a robot. Don't ask me.", 4],
	['Mage', 'res://characters/enemies/mage', 15,                   'A little eye that shoots bullets.', 3],
	['Bouncer', 'res://characters/enemies/bouncer', 20,             "It's capable of doing 1 homerun for every 5 swings.", 4],
	['Undead', 'res://characters/enemies/undead', 25,               "It's a zombie and a robot. Don't.", 16],
	['Absorber', 'res://characters/enemies/absorber', 30,           'You figure out what it does.', 4],
	['Hard Bouncer', 'res://characters/enemies/hard_bouncer', 45,   "It's capable of doing 5 homeruns for every 1 swing.", 10],
	['Hard Mage', 'res://characters/enemies/hard_mage', 55,         'A little eye that shoots bullets and teleports.', 5],
	['Hard Charger', 'res://characters/enemies/hard_charger', 65,   'Your greatest nightmare. Good luck.', 6],
	['Hard Shielded', 'res://characters/enemies/hard_shielded', 77, "It thinks it's a paladin.", 6]
]

const MECHANICS = [ # 17 mechanics
	['Simple Bullet', 'create_simple_bullet',     "It's simple. Do you want to know more? What part of simple did you not understand?"],
	['Trap', 'create_trap',                       "It goes off if an enemy goes over it. Of course they have to step on it first. *Giggle*"],
	['Tracer Bullet', 'create_tracer_bullet',     "If you make a hole in my wall I'll make sure you regret it."],
	['Dash', 'dash',                              "Dash!"],
	['Ghost Bullet', 'create_ghost_bullet',       'They used to say its scream sound comes from a test subject of an old evil experiment.'],
	['Wormhole', 'create_wormhole',               "A wormhole, it probably won't reduce your sanity."],
	['Armor', 'shield',                           "Won't protect you for long, don't rely too much on it."],
	['Ion Bullet', 'create_ion_bullet',           "It fries these damn robots circuits for a little time. It has a very different effect on organic lifeforms. Good old times."],
	['Guided Bullet', 'create_guided_bullet',     "Are you that lazy that you can't even bother to target the damn enemy?"],
	['Cure Bullet', 'create_cure_bullet',         "You're the last of the LAVA series LAMP edition. And you want to HEAL your enemies??"],
	['Shotgun', 'create_shotgun_bullet',          "The good old shotgun. It reloads automatically and it's probably the last of it's kind."],
	['Ricochet Bullet', 'create_ricochet_bullet', "A hardcore way to play pong."],
	['Storm', 'create_earthquake',                "You're part of the goddamn LAVA series, do you really need an upgrade to do a little Storm?"],
	['Charge Bullet', 'create_charge_bullet',     "Do you wanna be a megaman fanboy or something? Goddamn LAMPs these days."],
	['Laser', 'create_laser',                     "Light amplified by Anti A.T. Field until it becomes a deadly energy beam. Cats love them for some reason."],
	['Flamethrower', 'create_flamethrower',       "Try to not break it. I want to roast some marshmallows later."],
	['Double Bullet', 'create_double_bullet',     "The ultimate weapon. All science has converged to this. You are lucky to be alive and witness this."],
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
	'HAHA! It was so much fun watching you running away from them!',
	"Disappointed but not surprised.",
	"This is useless, we're all going to die anyway...",
	"I told them the LAMP edition would be awesome.",
	"Damn, that was close.",
	"Live and let live",
]

const START_SPEECHES = [
	'New wave incoming! Get ready for it!',
	'This will be a tough one! I hope you\'re prepared.',
	'DESTROY THEM ALL!!!',
	'You see it? They are coming to get you!',
	'Prepare for war!',
	'Get ready for the next battle!',
	"You have no idea what's coming next.",
	"Let's see what you're capable of",
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
const NEW_ENEMY_PROPORTION = 1/3

var reserved_keys = [ KEY_W, KEY_A, KEY_S, KEY_D, KEY_Q ]

var cur_wave = 1
var enemy_types = 1
var wave_points = 10
var key
var waiting_key = false
var cur_mechanics = 1
var cur_enemy = 1

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
	wave_points += cur_wave
	print(cur_wave, ' wave points ', wave_points)

var HealthPack = preload('res://scenario/props/health_pack.tscn')

func wave_ended():
	var lives = randi() % 3
	var text = END_SPEECHES[randi()%END_SPEECHES.size()]
	var wait_time = 6
	if lives > 0:
		text += " I left %d [color=lime]health pack%s[/color] for you as a reward. Go search for %s." % [lives, "s" if lives > 1 else "", "them" if lives > 1 else "it"]
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
	t.set_wait_time(wait_time)
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
	t.set_wait_time(5)
	t.disconnect('timeout', self, 'new_wave')
	t.connect('timeout', self, 'start_wave')
	t.set_one_shot(true)
	t.start()
	w.connect('ended', self, 'wave_ended')

func introduce_enemy_type():
	dialog_box.display_new_enemy(ENEMIES[cur_enemy][0], var2str(ENEMIES[cur_enemy][4]), ENEMIES[cur_enemy][3], load(ENEMIES[cur_enemy][1] + '_icon.tscn').instance())
	cur_enemy += 1

func new_wave():
	if (cur_wave%NEW_ENEMY_TYPE == 0):
		introduce_enemy_type()
	if (cur_wave%NEW_MECH_TYPE == 0):
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
