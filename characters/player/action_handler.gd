extends Node2D

const Cooldown = preload('res://gui/cooldown.tscn')

onready var gui = get_node('/root/Main/GUI')
onready var portrait = gui.get_node("Player_Portrait")

var selected_action = null

signal change_emotion(emotion, time)

var action_map = []
var capturing = true

func _ready():
	set_process_unhandled_key_input(true)
	
	get_node('/root/input').connect('press_action', self, 'do_selected_action')
	
	self.connect('change_emotion', portrait, 'change_emotion')
	
	action_map.resize(26)

func cooldown_end(act, key):
	act.on_cooldown = false
	if (key != -1 and Input.is_key_pressed(KEY_A + key)) or (key == -1 and Input.is_mouse_button_pressed(BUTTON_LEFT)):
		actually_do(act, key)

func set_key_to_action(key, action):
	if key< KEY_A or key > KEY_Z:
		breakpoint
	var action_script = load('res://actions/'+action+'.gd')
	action_map[key - KEY_A] = action_script.new()
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

onready var input = get_node('/root/input')

func do_action(key):
	var act = action_map[key]
	if act == null: return
	if input.control_type == input.MOUSE and not act.auto_play:
		selected_action = act
	elif not act.on_cooldown:
		actually_do(act, key)

func _unhandled_key_input(ev):
	var key = ev.scancode - KEY_A
	if key < 0 or key >= 26 or not ev.pressed or ev.echo or not capturing:
		return
	do_action(key)