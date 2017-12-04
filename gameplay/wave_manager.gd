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

const NEW_ENEMY_TYPE = 3
const NEW_ENEMY_PROPORTION = 1/3

var cur_wave = 1
var enemy_types = 1
var wave_points = 10

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

func new_wave():
	print('Wave ', cur_wave, ' started')
	var w = get_node('Wave')
	w.start()
	dialog_box.display_text("New wave incoming [color=purple]baby!![/color] Also this is a [color=blue]long[/color] [color=red]long[/color] [color=green]long[/color] long long long long long long long long long long long long text haha", 6)
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
