extends Node2D

onready var ap = get_node("Sprite/AnimationPlayer")

#Changed player portrait animation given an emotion
#Valid emotions: "normal", "angry", "happy", "surprised"
func change_emotion(emotion, time = 2):
	var anim
	if emotion == "normal":
		anim = "Normal"
	elif emotion == "angry":
		anim = "Angry"
	elif emotion == "surprised":
		anim = "Surprised"
	elif emotion == "happy":
		anim = "Happy"
		
	var player = get_node('/root/TestCellar/Props/Player')
	var exp_timer = player.get_node("Expression_Timer")
	
	if anim != ap.get_current_animation():
		ap.play(anim)
		if anim != "Normal":
			if not exp_timer.is_paused():
				exp_timer.stop()
			exp_timer.set_wait_time(time)
			exp_timer.start()
	#If playing the same animation, just update timer
	else:
		if anim != "Normal":
			if not exp_timer.is_paused():
				exp_timer.stop()
			exp_timer.set_wait_time(time)
			exp_timer.start()
