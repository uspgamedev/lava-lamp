extends Node2D

onready var ap = get_node("Sprite/AnimationPlayer")

func _ready():
	pass

#Changed player portrait animation given an emotion
#Valid emotions: "normal", "angry", "happy", "surprised"
func change_emotion(emotion):
	print("got here", emotion)
	var anim
	if emotion == "normal":
		anim = "Normal"
	elif emotion == "angry":
		anim = "Angry"
	elif emotion == "surprised":
		anim = "Surprised"
	elif emotion == "happy":
		anim = "Happy"

	if anim != ap.get_current_animation():
		ap.play(anim)

