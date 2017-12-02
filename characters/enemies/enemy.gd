extends 'res://characters/body.gd'

var s = 3

var player
var cd_timer

func _ready():
	player = get_node("../Player")
	cd_timer = get_node("Cooldown")
	set_fixed_process(true)
	
func _fixed_process(delta):
	if cd_timer.get_time_left() == 0:
		var vec = player.get_pos() - get_pos()
		move(s*vec/vec.length())

func _on_Area2D_area_enter( area ):
	if area.is_in_group("player_area"):
		var vec = player.get_pos() - get_pos()
		player.speed += 10*s*vec
		cd_timer.start()