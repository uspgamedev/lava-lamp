extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var charge_timer = get_node('ChargeTimer')
onready var main = get_node('../../')
onready var input = get_node('/root/input')
onready var pl = main.get_node('Props/Player')
onready var area = get_node('Area2D')

signal shoot

var shoot = false
var scale = 0

func _ready():
	timer.connect('timeout', self, 'queue_free')
	input.connect('not_hold_action', self, '_shoot')
	charge_timer.start()
	self.speed = Vector2()
	set_fixed_process(true)

func update_scale():
	self.scale = (charge_timer.get_wait_time() - charge_timer.get_time_left())/charge_timer.get_wait_time()
	if self.scale < 0.3:
		self.sprite.charge_small()
	elif self.scale < 0.6:
		self.sprite.charge_medium()
	else:
		self.sprite.charge_large()
	self.area.set_scale(Vector2(1+self.scale, 1+self.scale))
	self.set_pos(pl.get_pos() + Vector2(0, -20) + pl.get_look_vec()*16)

func _fixed_process(delta):
	if not shoot:
		update_scale()

func _shoot():
	if not self.shoot:
		self.shoot = true
		self.timer.start()
		self.speed = pl.get_look_dir().normalized() * 400
		self.update_scale()
		self.damage = 2*self.scale
		self.sprite.stop_charge()
		self.emit_signal('shoot')

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area') and shoot:
		var enemy = area.get_parent()
		enemy.ai.hit(self)
