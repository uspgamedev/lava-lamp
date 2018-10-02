extends Control

const TWEEN_DUR = .6
const CENTER_POS = Vector2(440, 440)
const RIGHT_POS = Vector2(1440, 440)
const LEFT_OFFSET = Vector2(-300, 0)
const OFFSCREEN_OFFSET = Vector2(-800, 0)

onready var buttons = $Buttons
onready var play_button = $Buttons/MainMenu/Play
onready var main_menu = $Buttons/MainMenu
onready var play_menu = $Buttons/PlayMenu
onready var options_menu = $Buttons/OptionsMenu
onready var tw = $Tween

func _ready():
	set_children_disability(play_menu, true)
	set_children_disability(options_menu, true)


func set_children_disability(menu, value):
	for child in menu.get_children():
		if "disabled" in child:
			child.disabled = value


func _on_Play_pressed():
	set_children_disability(main_menu, true)
	
	for child in main_menu.get_children():
		var offset = OFFSCREEN_OFFSET
		if child == play_button:
			offset = LEFT_OFFSET
		
		tw.interpolate_property(child, "rect_position", child.rect_position,
			child.rect_position + offset, TWEEN_DUR, Tween.TRANS_QUAD,
			Tween.EASE_IN_OUT)
	
	tw.interpolate_property(play_menu, "rect_position", play_menu.rect_position,
		CENTER_POS, TWEEN_DUR, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#	tw.interpolate_property(buttons, "rect_position", buttons.rect_position,
#		buttons.rect_position - Vector2(1280, 0), TWEEN_DUR, Tween.TRANS_QUAD,
#		Tween.EASE_IN_OUT)
	tw.start()
	
	yield(tw, "tween_completed")
	set_children_disability(play_menu, false)


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


func _on_Play_Back_pressed():
	set_children_disability(play_menu, true)
	
	for child in main_menu.get_children():
		var offset = -OFFSCREEN_OFFSET
		if child == play_button:
			offset = -LEFT_OFFSET
		
		tw.interpolate_property(child, "rect_position", child.rect_position,
			child.rect_position + offset, TWEEN_DUR, Tween.TRANS_QUAD,
			Tween.EASE_IN_OUT)
	
	tw.interpolate_property(play_menu, "rect_position", play_menu.rect_position,
		RIGHT_POS, TWEEN_DUR, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#	tw.interpolate_property(buttons, "rect_position", buttons.rect_position,
#		buttons.rect_position + Vector2(1280, 0), TWEEN_DUR, Tween.TRANS_QUAD,
#		Tween.EASE_IN_OUT)
#	tw.start()
	
	yield(tw, "tween_completed")
	set_children_disability(main_menu, false)


func _on_Options_Back_pressed():
	pass # replace with function body
