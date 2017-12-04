extends Node2D

const Cooldown = preload('res://gui/cooldown.tscn')

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node("Player_Portrait")
onready var input = get_node('/root/input')

var selected_action = null

signal change_emotion(emotion, time)

var action_map = []

func _ready():
	set_process_unhandled_key_input(true)
	
	self.connect('change_emotion', portrait, 'change_emotion')
	
	action_map.resize((KEY_Z - KEY_A + 1) + (KEY_9 - KEY_0 + 1))

func cooldown_end(act, key):
	act.on_cooldown = false
	if (key != -1 and Input.is_key_pressed(KEY_A + key)) or (key == -1 and input._get_action(Input) == 1 and selected_action == act):
		actually_do(act, key)

func map_key(key):
	if key >= KEY_A and key <= KEY_Z:
		return key - KEY_A
	elif key >= KEY_0 and key <= KEY_9:
		return key - KEY_0 + (KEY_Z - KEY_A) + 1
	else:
		return -1

func unmap_key(key):
	if key >= 0 and key <= KEY_Z - KEY_A:
		return key + KEY_A
	elif key > KEY_Z - KEY_A and key <= KEY_9 - KEY_0 + (KEY_Z - KEY_A) + 1:
		return key - (KEY_Z - KEY_A) - 1 + KEY_0
	else:
		return -1

func set_key_to_action(key, action):
	if map_key(key) == -1:
		breakpoint
	var action_script = load('res://actions/'+action+'.gd')
	action_map[map_key(key)] = action_script.new()
	if action == 'create_simple_bullet':
		selected_action = action_map[map_key(key)]
	print("Setted action ", action, " to key ", RawArray([key]).get_string_from_utf8())

func actually_do(act, key):
	var obj = act.activate(self, key)
	if obj:
		yield(obj, "finish")
	act.on_cooldown = true
	var name = act.get_name()
	if name == "wormhole":
		emit_signal('change_emotion', "surprised", .7)
	elif name != "dash":
		var player = get_parent()
		player.start_shooting()
	var cd = Cooldown.instance()
	cd.icon = act.icon
	get_node('/root/Main/GUI/Cooldowns').add_cooldown(cd)
	cd.set_max(act.cooldown_time)
	cd.connect('cooldown_end', self, 'cooldown_end', [act, key])

func do_selected_action(_):
	if selected_action == null or selected_action.on_cooldown: return
	actually_do(selected_action, -1)


func do_action(key):
	var act = action_map[key]
	if act == null: return
	if input.control_type == input.MOUSE and not act.auto_play:
		selected_action = act
		if input._get_action(Input) == 1 and not act.on_cooldown:
			actually_do(selected_action, -1)
	elif not act.on_cooldown:
		actually_do(act, key)

func _unhandled_key_input(ev):
	var key = map_key(ev.scancode)
	if key == -1 or not ev.pressed or ev.echo:
		return
	do_action(key)