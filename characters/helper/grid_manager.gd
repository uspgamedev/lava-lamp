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

var lbs = []
func calc_distances():
	var p = get_parent()
	var tm = get_node('/root/Main/Floor')
	var cood = tm.world_to_map(p.get_pos())
	var i = 0
	var q = []
	q.append(cood)
	print(cood, tm.get_cellv(cood))
	dist.clear()
	nxt.clear()
	dist[cood] = 0
	nxt[cood] = cood
	for l in lbs:
		l.queue_free()
	lbs.clear()
	while(i < q.size()):
		var p = q[i]
		i += 1
		for di in range(-1, 2):
			for dj in range(-1, 2):

				var pp = p + Vector2(di, dj)
				if not dist.has(pp) and tm.get_cellv(pp) != -1 and tm.get_cellv(pp) != 3:
					dist[pp] = dist[p] + 1
					nxt[pp] = p
					q.append(pp)
					var s = ""
					if di == 1: s = "^"
					elif di == -1: s = "v"
					elif dj == 1: s = "<-"
					else: s = "->"
					var l = Label.new()
					l.set_text(str(pp) + " " + str(dist[pp]));
					#l.set_text(s + " " + str(dist[pp]))
					l.set_pos(tm.map_to_world(pp))
					l.set_scale(Vector2(.5,.5))
					tm.get_parent().add_child(l)
					lbs.append(l)