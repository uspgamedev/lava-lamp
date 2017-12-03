var dist = {}
var nxt = {}
var cur = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(dt):
	cur += dt
	if cur >= 1:
		cur = 0
		calc_distances()

func ok_tile(tm, tm2, cood):
	return tm.get_cellv(cood) != -1 and tm.get_cellv(cood) != 3 and tm2.get_cellv(cood) == -1

func calc_distances():
	var p = get_parent()
	var tm = get_node('/root/Main/Floor')
	var tm2 = get_node('/root/Main/Props')
	var cood = tm.world_to_map(p.get_pos() - Vector2(0, 30))
	var i = 0
	var q = []
	q.append(cood)
	dist.clear()
	nxt.clear()
	dist[cood] = 0
	nxt[cood] = cood
	while(i < q.size()):
		var p = q[i]
		i += 1
		for di in range(-1, 2):
			for dj in range(-1, 2):
				# Cannot go diagonally if any of the sides are blocked
				if not ok_tile(tm, tm2, p + Vector2(di, 0)) or not ok_tile(tm, tm2, p + Vector2(0, dj)):
					continue
				var pp = p + Vector2(di, dj)
				if not dist.has(pp) and ok_tile(tm, tm2, pp):
					dist[pp] = dist[p] + 1
					nxt[pp] = p
					q.append(pp)