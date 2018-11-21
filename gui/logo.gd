extends Node2D

onready var timer = get_node("Timer")
onready var active = false

func _ready():
	hide()

func start_logo_animation():
	active = true
	show()
	timer.set_wait_time(4)
	timer.start()
		
func stop_logo_animation():
	if get_node('/root/input').is_connected('skip_intro', get_node('/root/Main/Map/Props/Player'), 'skip_intro'):
		get_node('/root/input').disconnect('skip_intro', get_node('/root/Main/Map/Props/Player'), 'skip_intro')
	active = false
	hide()

func is_logo_active():
	return active

func _on_Timer_timeout():
	stop_logo_animation()
