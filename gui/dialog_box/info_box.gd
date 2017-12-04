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

var SpinningBox = preload('res://gui/3d/viewport_3d.tscn')

func set_icon(icon):
	var sb = SpinningBox.instance()
	sb.get_node('Viewport/Spatial').set_texture(icon)
	add_child(sb)
	#sb.set_scale(Vector2(4, 4))
	#sb.get_node('Viewport/Spatial').set_scale(Vector3(4,4,4))
	sb.set_pos(Vector2(0,0))

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