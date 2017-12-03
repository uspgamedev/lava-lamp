extends Node

const INVALID = -1
const UP = 0
const RIGHT = 1
const DOWN = 2
const LEFT = 3
const UP_RIGHT = 4
const DOWN_RIGHT = 5
const DOWN_LEFT = 6
const UP_LEFT = 7

const VECTOR = [
	Vector2(cos( 2*PI/4 ), -sin( 2*PI/4 )),
	Vector2(cos( 0*PI/4 ), -sin( 0*PI/4 )),
	Vector2(cos(-2*PI/4 ), -sin(-2*PI/4 )),
	Vector2(cos( 4*PI/4 ), -sin( 4*PI/4 )),

	Vector2(cos( 1 * PI/4), -sin( 1 * PI/4)),
	Vector2(cos(-1 * PI/4), -sin(-1 * PI/4)),
	Vector2(cos(-3 * PI/4), -sin(-3 * PI/4)),
	Vector2(cos( 3 * PI/4), -sin( 3 * PI/4)),
]

static func vec2rot(vec):
	var angle = vec.angle()
	var int_angle = round(angle/(PI/2)) * PI/2
	return int_angle
