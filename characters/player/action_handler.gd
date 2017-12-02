extends Node2D

var action_map = []
const Cooldown = preload('res://gui/cooldown.tscn')

func _ready():
	set_process_unhandled_key_input(true)
	action_map.resize(26)
	action_map[1] = preload('res://actions/debug.gd').new()
	action_map[21] = preload('res://actions/dash.gd').new()
	action_map[2] = preload('res://actions/create_simple_bullet.gd').new()
	action_map[13] = preload('res://actions/create_trap.gd').new()

func cooldown_end(act):
	act.on_cooldown = false

func _unhandled_key_input(ev):
	var key = ev.scancode - KEY_A
	if key < 0 or key >= 26 or not ev.pressed or ev.echo:
		return
	if action_map[key] != null and not action_map[key].on_cooldown:
		var act = action_map[key];
		act.activate(self)
		act.on_cooldown = true
		var cd = Cooldown.instance()
		cd.icon = act.icon
		get_node('/root/Main/GUI/Cooldowns').add_cooldown(cd);
		cd.set_max(act.cooldown_time)
		cd.connect('cooldown_end', self, 'cooldown_end', [act])