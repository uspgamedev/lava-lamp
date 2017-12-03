var dist = {}
var nxt = {}
var seen = {}
var cur = 0

onready var tm = get_node('/root/Main/Floor')
onready var tm2 = get_node('/root/Main/Props')

func _ready():
	set_fixed_process(true)
	start_calc()

var q = []
var qi = 0

var qc = []
var qic = 0
var seenc = {}

func start_calc():
	seen = {}
	q = []
	qi = 0
	var cood = tm.world_to_map(get_parent().get_pos() - Vector2(0, 30))
	q.append(cood)
	seen[cood] = true
	dist[cood] = 0
	nxt[cood] = cood

func _fixed_process(dt):
	for i in range(10):
		continue_calc_distances()

func ok_tile(tm, tm2, cood):
	return tm.get_cellv(cood) != -1 and tm.get_cellv(cood) != 3 and tm2.get_cellv(cood) == -1

func continue_calc_distances():
	if qi == q.size():
		start_calc()
	var p = q[qi]
	qi += 1
	for di in range(-1, 2):
		for dj in range(-1, 2):
			# Cannot go diagonally if any of the sides are blocked
			if di != 0 and dj != 0 and (not ok_tile(tm, tm2, p + Vector2(di, 0)) or not ok_tile(tm, tm2, p + Vector2(0, dj))):
				continue
			var pp = p + Vector2(di, dj)
			if not seen.has(pp) and ok_tile(tm, tm2, pp):
				seen[pp] = true
				if dist.has(pp) and dist[pp] == dist[p] + 1: continue
				dist[pp] = dist[p] + 1
				nxt[pp] = p
				q.append(pp)
	## BFS only for close points
	if qic == qc.size():
		qc = []
		seenc = {}
		qic = 0
		var cood = tm.world_to_map(get_parent().get_pos() - Vector2(0, 30))
		qc.append(cood)
		seenc[cood] = true
		dist[cood] = 0
		nxt[cood] = cood
	p = qc[qic]
	qic += 1
	for di in range(-1, 2):
		for dj in range(-1, 2):
			# Cannot go diagonally if any of the sides are blocked
			if di != 0 and dj != 0 and (not ok_tile(tm, tm2, p + Vector2(di, 0)) or not ok_tile(tm, tm2, p + Vector2(0, dj))):
				continue
			var pp = p + Vector2(di, dj)
			if not seenc.has(pp) and ok_tile(tm, tm2, pp):
				seenc[pp] = true
				if dist.has(pp) and dist[pp] == dist[p] + 1: continue
				dist[pp] = dist[p] + 1
				nxt[pp] = p
				if dist[pp] < 5:
					qc.append(pp)