extends Node2D

onready var timer = get_node("Timer")

func _ready():
	hide()

func start_logo_animation():
	show()
	timer.set_wait_time(4)
	timer.start()
		
func stop_logo_animation():
	hide()

func _on_Timer_timeout():
	stop_logo_animation()
