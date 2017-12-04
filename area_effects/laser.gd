extends 'res://area_effects/area_effect.gd'
const LaserTile = preload('res://area_effects/laser_tile.tscn')

onready var timer = get_node('Timer')
onready var tiles = get_node('Tiles')

var player
var pos = 0

func _ready():
	damage = 0.5
	timer.connect('timeout', self, 'queue_free')
	timer.start()
	set_fixed_process(true)
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
	
