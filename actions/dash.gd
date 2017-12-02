const DASHTIME = 0.1
const DASHCOOLDOWN = 0.35

static func activate(action_handler):
	var player = action_handler.get_parent()
	if player.dashCooldown <= 0:
		player.dashTime = DASHTIME
		player.dashCooldown = DASHCOOLDOWN