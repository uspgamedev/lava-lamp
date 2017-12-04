extends Node2D

export(int, 40, 100) var tot_width = 80
export(Color) var color = Color(0, 1, 0)
export(int, 3, 6) var max_in_row = 4
export(int, 0, 50) var gapx = 10
export(int, 0, 50) var gapy = 20

func _draw():
	var enemy = get_parent()
	var sc = 1
	var w = 30
	var h = 20
	var gap = 10
	var wd = min(enemy.hp, max_in_row)
	var totw = w * wd + gapx * (wd - 1)
	var x = -totw / 2
	var y = 0
	sc = float(tot_width) / totw
	for i in range(enemy.hp):
		if i < enemy.hp - enemy.damage:
			draw_rect(Rect2(x * sc, y * sc, w * sc, h * sc), color)
		else:
			var rt = [Vector2(x * sc, y * sc), Vector2((x + w) * sc, y * sc), Vector2((x + w) * sc, (y + h) * sc), Vector2(x * sc, (y + h) * sc)]
			for j in range(4):
				draw_line(rt[j], rt[(j + 1) % 4], color)
		x += (w + gapx)
		if ((i + 1) % wd) == 0:
			x = -totw / 2
			y += h + gapy