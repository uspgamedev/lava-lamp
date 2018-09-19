extends Node2D

const DIR = preload('res://characters/player/input/directions.gd')

onready var active_enemy
onready var polygon = get_node("Polygon2D")

func _ready():
	polygon.hide()

func _physics_process(delta):
	if active_enemy == null or active_enemy.get_ref() == null:
		pick_active_enemy()
	else:
		check_distance_of_active_enemy()
	
	if active_enemy != null:
		activate_arrow()
	else:
		deactivate_arrow()

func activate_arrow():
	if not polygon.is_visible():
		polygon.show()
	update_helper_arrow()

func deactivate_arrow():
	active_enemy = null
	polygon.hide()

func is_far_enough(e_pos):
	var scale = get_node('/root/Main/').get_scale()
	
	var player = get_parent()
	var p_pos = player.get_position()
	
	var rect = get_viewport().get_visible_rect()
	var rw = rect.size.x *1.2
	var rh = rect.size.y *1.2
	var px = p_pos.x*scale.x
	var py = p_pos.y*scale.y
	var ex = e_pos.x*scale.x
	var ey = e_pos.y*scale.y

	if ex < px - rw/2 or ex > px + rw/2 or ey < py - rh/2 or ey > py + rh/2:
		return true
	
	return false

#Chooses a random enemy outside screen to show its position
func pick_active_enemy():
	active_enemy = null
	
	var player = get_parent()

	for enemy in get_tree().get_nodes_in_group("enemy"):
		var e_pos = enemy.get_position()
		var p_pos = player.get_position()
		if is_far_enough(e_pos):
			active_enemy = weakref(enemy)
			return

#If enemy is close enough to player, remove polygon
func check_distance_of_active_enemy():
	var e = active_enemy.get_ref()
	var player = get_parent()
		
	var e_pos = e.get_position()
	if not is_far_enough(e_pos):
		deactivate_arrow()
		return

func update_helper_arrow():
	var scale = get_node('/root/Main/').get_scale()
	var e = active_enemy.get_ref()
	
	var player = get_parent()
	var camera = player.get_node("Camera")
	
	var e_pos = e.get_position()
	var p_pos = player.get_position()

	var w = get_viewport().size.x
	var h = get_viewport().size.y
	
	var angle = p_pos.angle_to_point(e_pos) - PI/2
	
	polygon.set_rotation(angle)
	
	var dist = 120
	var center = camera.get_offset()*scale
	var x = center.x + sin(angle)*dist 
	var y = center.y + -cos(angle)*dist 
	var polygon_pos = Vector2(x, y)
	polygon.set_position(polygon_pos)
