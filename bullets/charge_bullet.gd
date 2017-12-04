extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var charge_timer = get_node('ChargeTimer')
onready var col_poly = get_node('Area2D/CollisionPolygon2D')
onready var main = get_node('../../')
onready var input = get_node('/root/input')
onready var pl = main.get_node('Props/Player')
onready var area = get_node('Area2D')

signal finish

const polygons = [Vector2Array([Vector2(-5, -5), Vector2(5, -5),
								Vector2(5, 5), Vector2(-5, 5)]),
				  Vector2Array([Vector2(-8, -8), Vector2(8, -8),
								Vector2(8, 8), Vector2(-8, 8)]),
				  Vector2Array([Vector2(-15, -15), Vector2(15, -15),
							    Vector2(15, 15), Vector2(-15, 15)])]

var shoot = false
var scale = 0
var hold_key

func _ready():
	timer.connect('timeout', self, 'queue_free')
	charge_timer.start()
	self.speed = Vector2()
	set_fixed_process(true)
	set_process_unhandled_key_input(true)

func update_scale():
	self.scale = (charge_timer.get_wait_time() - charge_timer.get_time_left())/charge_timer.get_wait_time()
	if self.scale < 0.3:
		self.sprite.charge_small()
		col_poly.set_polygon(polygons[0])
	elif self.scale < 0.6:
		self.sprite.charge_medium()
		col_poly.set_polygon(polygons[1])
	else:
		self.sprite.charge_large()
		col_poly.set_polygon(polygons[2])
	self.set_pos(pl.get_pos() + pl.get_look_vec()*16)

func _fixed_process(delta):
	if not shoot:
		update_scale()

func _unhandled_key_input(ev):
	if ev.scancode == hold_key and not ev.pressed:
		_shoot()

func _shoot():
	if not self.shoot:
		set_process_unhandled_key_input(false)
		self.shoot = true
		self.timer.start()
		self.speed = pl.get_look_dir().normalized() * 400
		self.update_scale()
		if self.scale < .3:
			self.damage = 1
		elif self.scale < 0.6:
			self.damage = 2
		else:
			self.damage = 3
		self.sprite.stop_charge()
		self.emit_signal('finish')
		pl.sfx.play("Special")

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area') and shoot:
		var enemy = area.get_parent()
		enemy.ai.hit(self)
	if damages_player and area.get_parent().get_name() == 'Player':
		var player = area.get_parent()
		player.deal_damage(self.damage)
		queue_free()
