extends Control

const TWEEN_DUR = .6
const CENTER_POS = Vector2(440, 440)
const RIGHT_POS = Vector2(1440, 440)
const LEFT_OFFSET = Vector2(-300, 0)
const OFFSCREEN_OFFSET = Vector2(-800, 0)

enum {LEFT, RIGHT}

onready var buttons = $Buttons
onready var play_button = $Buttons/MainMenu/Play
onready var options_button = $Buttons/MainMenu/Options
onready var main_menu = $Buttons/MainMenu
onready var play_menu = $Buttons/PlayMenu
onready var options_menu = $Buttons/OptionsMenu
onready var tw = $Tween
onready var game_mode = get_node('/root/game_mode')

func _ready():
	set_children_disability(play_menu, true)
	set_children_disability(options_menu, true)
	tw.start()
	
	$Buttons/OptionsMenu/MusicSlider.value = options.configs.music
	$Buttons/OptionsMenu/SFXSlider.value = options.configs.sfx
	$Buttons/OptionsMenu/FullscreenBox.pressed = options.configs.fullscreen


func set_children_disability(menu, value):
	for child in menu.get_children():
		if "disabled" in child:
			child.disabled = value


func main_menu_animation(pressed_button, from_menu, to_menu):
	set_children_disability(from_menu, true)
	
	# Main menu buttons animation
	for child in main_menu.get_children():
		var offset = OFFSCREEN_OFFSET
		if child == pressed_button:
			offset = LEFT_OFFSET
		if from_menu != main_menu:
			offset *= -1
		
		tw.interpolate_property(child, "rect_position", child.rect_position,
			child.rect_position + offset, TWEEN_DUR, Tween.TRANS_QUAD,
			Tween.EASE_IN_OUT)
	
	# Selected menu animation
	var pos = CENTER_POS
	var menu = to_menu
	if from_menu != main_menu:
		pos = RIGHT_POS
		menu = from_menu
	tw.interpolate_property(menu, "rect_position", menu.rect_position, pos,
		TWEEN_DUR, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	yield(tw, "tween_completed")
	set_children_disability(to_menu, false)


func _on_Play_pressed():
	main_menu_animation(play_button, main_menu, play_menu)


func _on_Options_pressed():
	main_menu_animation(options_button, main_menu, options_menu)


func _on_Credits_pressed():
	get_node('/root/bgm_global').play_credits()
	get_tree().change_scene("res://menu/credits/credits.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Story_pressed():
	pass # replace with function body


func _on_Arcade_pressed():
	game_mode.mode = game_mode.ARCADE
	get_tree().change_scene("res://menu/map_selection/map_selection.tscn")


func _on_Survival_pressed():
	game_mode.mode = game_mode.SURVIVAL
	get_tree().change_scene("res://menu/map_selection/map_selection.tscn")


func _on_Play_Back_pressed():
	main_menu_animation(play_button, play_menu, main_menu)


func _on_Options_Back_pressed():
	main_menu_animation(options_button, options_menu, main_menu)
	options.save_options()


func _on_FullscreenBox_toggled(button_pressed):
	options.toggle_fullscreen(button_pressed)


func _on_SFXSlider_value_changed(value):
	options.change_volume(value, 100, 2)
	$SliderSFX.play()


func _on_MusicSlider_value_changed(value):
	options.change_volume(value, 100, 1)
