extends Node2D

onready var input = get_node('/root/input')
onready var bgm = get_node("BGM")

func _ready():
	input.set_control_type(input.MOUSE)
	input.set_pause_mode(input.PAUSE_MODE_PROCESS)
	input.connect('press_quit', self, 'quit')

func quit():
	get_tree().quit()

func get_valid_position():
	var wall_tile_map = get_node("Props")
	var floor_tile_map = get_node("Floor")
	var cells = floor_tile_map.get_used_cells()
	var cell = cells[randi()%cells.size()]
	var player = wall_tile_map.get_node('Player')
	while (((cell - floor_tile_map.world_to_map(player.get_position())).length() < 15) or \
	      (floor_tile_map.get_cell(cell.x, cell.y) == 3 or wall_tile_map.get_cell(cell.x, cell.y) != -1)):
		cell = cells[randi()%cells.size()]
	var position = wall_tile_map.map_to_world(cell) + Vector2(12, -12)
	return position

func is_a_valid_position(pos):
	var floor_tile_map = get_node("Floor")
	var cell = floor_tile_map.get_cell(floor_tile_map.world_to_map(pos).x, \
	                                   floor_tile_map.world_to_map(pos).y)
	if (cell == 3 or cell != -1):
		return true
	return false
