extends Node2D

var action_map = []
const Cooldown = preload('res://gui/cooldown.tscn')

func _ready():
	set_process_unhandled_key_input(true)
	action_map.resize(26)

func cooldown_end(act, key):
	act.on_cooldown = false
	if Input.is_key_pressed(KEY_A + key):
		do_action(key)

func set_key_to_action(key, action):
	if key< KEY_A or key > KEY_Z:
		breakpoint
	var action_script = load('res://actions/'+action+'.gd')
	action_map[key - KEY_A] = action_script.new()
	print("Setted action ", action, " to key ", RawArray([key]).get_string_from_utf8())

func do_action(key):
	if action_map[key] != null and not action_map[key].on_cooldown:
		var act = action_map[key];
		act.activate(self)
		act.on_cooldown = true
		var cd = Cooldown.instance()
		cd.icon = act.icon
		get_node('/root/Main/GUI/Cooldowns').add_cooldown(cd);
		cd.set_max(act.cooldown_time)
		cd.connect('cooldown_end', self, 'cooldown_end', [act, key])

func _unhandled_key_input(ev):
	var key = ev.scancode - KEY_A
	if key < 0 or key >= 26 or not ev.pressed or ev.echo:
		return
	do_action(key)