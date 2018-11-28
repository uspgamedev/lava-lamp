extends Node

var intro
var credits
var intro_node
var credits_node

func _ready():
	intro = load('res://menu/Intro.ogg')
	intro_node = AudioStreamPlayer.new()
	intro_node.stream = intro
	intro_node.stream = intro
	self.add_child(intro_node)
	
	credits = load('res://menu/Credits.ogg')
	credits_node = AudioStreamPlayer.new()
	credits_node.stream = credits
	self.add_child(credits_node)
	
	intro_node.play()

func stop_all():
	intro_node.stop()
	credits_node.stop()

func play_intro():
	intro_node.play()
	credits_node.stop()

func play_credits():
	intro_node.stop()
	credits_node.play()