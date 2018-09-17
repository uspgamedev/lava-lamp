extends Node2D

const COOLDOWN = preload('res://gui/cooldown.tscn')

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node("Player_Portrait")
onready var input = get_node('/root/input')

var selected_action = null
var can_do = true

signal change_emotion(emotion, time)

var action_map = []
var keys_used = []

func _ready():
	self.connect('change_emotion', portrait, 'change_emotion')
	
	action_map.resize(KEY_LAUNCHF)

func cooldown_end(act, key):
	act.on_cooldown = false
	if (key != -1 and Input.is_key_pressed(key)) or (key == -1 and input._get_action(Input) == 1 and selected_action == act):
		actually_do(act, key)

func get_keys_used():
	return keys_used

func set_used_key(key):
	keys_used.append(key)

func set_selected_action(act):
	print("selecting %s" % act.name)
	selected_action = act
	var sa = get_node('/root/Main/GUI/SelectedAction/Node2D')
	for i in range(sa.get_child_count()):
		sa.get_child(i).queue_free()
	sa.add_child(act.icon.instance())

func set_key_to_action(key, action):
	var action_script = load('res://actions/'+action+'.gd')
	action_map[key] = action_script.new()
	if action == 'create_simple_bullet':
		set_selected_action(action_map[key])
	print("Setted action ", action, " to key ", PoolByteArray([key]).get_string_from_utf8())

func actually_do(act, key):
	if not can_do:
		return
	can_do = false
	get_parent()._set_look_dir(input._get_look_direction(Input))
	var name = act.name
	var player = get_parent()
	if name == "wormhole":
		emit_signal('change_emotion', "surprised", .7)
	elif name != "dash":
		var time = 0.45
		if name == "flamethrower" or name == "laser":
			time = 3
		elif name == "charge_bullet":
			time = 1.5
		player.start_shooting(time)
	var obj = act.activate(self, key)
	if obj:
		yield(obj, "finish")
		player.stop_shooting()
	act.on_cooldown = true
	var cd = COOLDOWN.instance()
	cd.icon = act.icon
	get_node('/root/Main/GUI/Cooldowns').add_cooldown(cd)
	cd.set_max(act.cooldown_time)
	cd.connect('cooldown_end', self, 'cooldown_end', [act, key])
	can_do = true

func do_selected_action(_arg):
	if selected_action == null or selected_action.on_cooldown:
		#self.get_parent().sfx.get_node("Fail").play()
		return
	actually_do(selected_action, -1)

func do_action(key):
	var act = action_map[key]
	if act == null: return
	if not input.shoot_on_click and not act.auto_play:
		set_selected_action(act)
		if input._get_action(Input) == 1 and not act.on_cooldown:
			actually_do(selected_action, -1)
	elif not act.on_cooldown:
		actually_do(act, key)
	else:
		#self.get_parent().sfx.get_node("Fail").play()
		pass

func _unhandled_input(ev):
	var key
	if (ev is InputEventMouseButton):
		key = ev.button_index
	elif (ev is InputEventKey):
		key = ev.scancode
		if not ev.pressed or ev.echo:
			return
	else: return
	do_action(key)
