extends Control

const TWEEN_DUR = .6

onready var buttons = $Buttons
onready var main_buttons = $Buttons/MainButtons
onready var play_buttons = $Buttons/PlayButtons
onready var tw = $Tween

func _ready():
	set_children_disability(play_buttons, true)


func set_children_disability(menu, value):
	for button in menu.get_children():
		if "disabled" in button:
			button.disabled = value


func _on_Play_pressed():
	set_children_disability(main_buttons, true)
	
	tw.interpolate_property(buttons, "rect_position", buttons.rect_position,
		buttons.rect_position - Vector2(1280, 0), TWEEN_DUR, Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)
	tw.start()
	
	yield(tw, "tween_completed")
	set_children_disability(play_buttons, false)


func _on_Options_pressed():
	pass # replace with function body


func _on_Credits_pressed():
	get_tree().change_scene("res://menu/credits/credits.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Story_pressed():
	pass # replace with function body


func _on_Arcade_pressed():
	get_node('/root/game_mode').mode = 0
	get_tree().change_scene('res://main.tscn')


func _on_Survival_pressed():
	get_node('/root/game_mode').mode = 1
	get_tree().change_scene('res://main.tscn')


func _on_Back_pressed():
	set_children_disability(play_buttons, true)
	
	tw.interpolate_property(buttons, "rect_position", buttons.rect_position,
		buttons.rect_position + Vector2(1280, 0), TWEEN_DUR, Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)
	tw.start()
	
	yield(tw, "tween_completed")
	set_children_disability(main_buttons, false)
