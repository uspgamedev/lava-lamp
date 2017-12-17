extends Polygon2D

onready var anim_player = get_node("AnimationPlayer")
onready var active = false

func is_active():
	return active

func activate():
	active = true
	anim_player.play("Activate")

func deactivate():
	if active == false:
		return
	active = false
	anim_player.play("Deactivate")
	anim_player.connect("finished", self, "kill_me")

func kill_me():
	queue_free()

func get_width():
	return 260
	
func set_top_text(text):
	get_node("Top Text").set_bbcode(text)
	get_node("Top Text").set_scroll_active(false)

func set_title(text):
	get_node("Title").set_bbcode(text)
	get_node("Title").set_scroll_active(false)

var B = preload('res://gui/3d/viewport_3d.tscn')

var SpinningBox = preload('res://gui/3d/viewport_3d.tscn')

func set_icon(icon):
	add_child(icon)
	if (icon.get_type() == 'Node2D'):
		var arrow = icon.get_node('Arrow')
		if arrow != null:
			arrow.hide()
			icon.set_pos(Vector2(0, 40))
		icon.set_scale(Vector2(4, 4))
	elif (icon.get_type() == 'Particles2D'):
		icon.set_scale(Vector2(3, 1.3))
		if (icon.get_name() == 'FireParticles'):
			icon.set_scale(Vector2(2, 2))
			icon.set_pos(Vector2(0, 40))
	elif (icon.get_type() == 'Sprite'):
		var size = icon.get_texture().get_size()
		size = Vector2(size.x/icon.get_hframes(), size.y/icon.get_vframes())
		var height = 120
		var width = 120
		var scale = max(height/size.x, width/size.y)
		icon.set_scale(Vector2(scale, scale))
		if (icon.get_name() == 'StormSprite'):
			icon.set_scale(Vector2(2, 2))
			icon.set_pos(Vector2(0, 10))

func set_description(text):
	get_node("Description").set_bbcode(text)
	get_node("Description").set_scroll_active(false)

func set_bottom_text(text):
	get_node("Bottom Text").set_bbcode(text)
	get_node("Bottom Text").set_scroll_active(false)

func set_bg_color(mode):
	if mode == "enemy":
		set_color(Color(0.93, 0, 0.07, 0.88))
	elif mode == "ability":
		set_color(Color(0.07, 0.61, 0.1, 0.88))