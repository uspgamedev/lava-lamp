extends Node

var configs = {
	"fullscreen" : false,
	"sfx" : 100,
	"music" : 100
}

func _ready():
	load_options()
	change_volume(configs.music, 100, 1)
	change_volume(configs.sfx, 100, 2)
	toggle_fullscreen(configs.fullscreen)

func load_options():
	var file = File.new()
	if not file.file_exists("user://options.json"):
		return
	file.open('user://options.json', File.READ)
	configs = parse_json(file.get_as_text())
	file.close()
	
func save_options():
	var file = File.new()
	if file.open('user://options.json', File.WRITE) != 0:
		return
	file.store_line(to_json(configs))
	file.close()

func change_volume(value, max_value, bus_index):
	var volume = -80
	if value > 0:
		volume = 10 * log(value / max_value)
	AudioServer.set_bus_volume_db(bus_index, volume)
	
	if bus_index == 1:
		configs.music = value
	elif bus_index == 2:
		configs.sfx = value

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	configs.fullscreen = value