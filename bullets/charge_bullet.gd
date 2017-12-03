extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var charge_timer = get_node('ChargeTimer')
onready var main = get_node('../../')
onready var input = get_node('/root/input')
onready var pl = main.get_node('Props/Player')

signal shoot

var shoot = false

func _ready():
	timer.connect('timeout', self, 'queue_free')
	input.connect('not_hold_action', self, '_shoot')
	charge_timer.start()
	self.speed = Vector2()
	set_fixed_process(true)

func _fixed_process(delta):
	if not shoot:
		var scale = (charge_timer.get_wait_time() - charge_timer.get_time_left())/charge_timer.get_wait_time()
		self.set_scale(Vector2(scale, scale))
		self.set_pos(pl.get_pos() + Vector2(0, -20))

func _shoot():
	if not shoot:
		shoot = true
		timer.start()
		self.speed = pl.get_look_dir().normalized() * 400
		self.set_pos(pl.get_pos() + Vector2(0, -20))
		var scale = (charge_timer.get_wait_time() - charge_timer.get_time_left())/charge_timer.get_wait_time()
		self.set_scale(Vector2(scale, scale))
		self.damage = 2*scale
		emit_signal('shoot')

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area') and shoot:
		var enemy = area.get_parent()
		enemy.ai.hit_by_bullet(enemy, self)
