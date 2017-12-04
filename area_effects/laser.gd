extends 'res://area_effects/area_effect.gd'
const LaserTile = preload('res://area_effects/laser_tile.tscn')

onready var timer = get_node('Timer')
onready var tiles = get_node('Tiles')
onready var sfx = get_node('SFX')

signal finish

var player
var pos = 0
var pressed = 0

func _ready():
	damage = 0.5
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	self.sfx.play('Bling')
	set_fixed_process(true)
	set_process_unhandled_input(true)
	var head = self.tiles.get_node('Head')
	for i in range(40):
		var tile = LaserTile.instance()
		self.tiles.add_child(tile)
		tile.set_pos(head.get_pos() + (i+1)*32*Vector2(0,1))
		tile.get_node("Area2D").connect("area_enter", self, "_on_Area2D_area_enter")

func _fixed_process(delta):
	self.set_pos(self.player.get_pos() + self.player.get_look_vec()*5)
	self.update_tiles()

func _on_Area2D_area_enter(area):
	if area.is_in_group('enemy_area'):
		area.get_parent().ai.hit(self)

func _unhandled_input(ev):
	if ev.is_action_released("keyboard2_click"):
		pressed -= 1
	elif ev.is_action_pressed("keyboard2_click"):
		pressed += 1
	if input.control_type == input.KEYBOARD2 and ev.type == InputEvent.KEY and \
		pressed == 0:
		_queue_free()
	elif input.control_type == input.MOUSE and ev.type == InputEvent.MOUSE_BUTTON and \
		 ev.button_index == BUTTON_LEFT and not ev.pressed:
		_queue_free()


func update_tiles():
	var look_ang = self.player.get_look_dir().angle()
	var wall_tm = self.player.get_parent()
	self.tiles.set_rot(look_ang)
	var i = 0
	while i < self.tiles.get_child_count():
		var tile = self.tiles.get_child(i)
		var map = wall_tm.world_to_map(get_pos() + tiles.get_pos() + tile.get_pos().rotated(look_ang))
		if (wall_tm.get_cell(map.x, map.y) != -1):
			break
		tile.set_hidden(false)
		tile.area.set_enable_monitoring(true)
		i += 1
	while i < self.tiles.get_child_count():
		var tile = self.tiles.get_child(i)
		tile.set_hidden(true)
		tile.area.set_enable_monitoring(false)
		i += 1
		
func _queue_free():
	emit_signal("finish")
	queue_free()
