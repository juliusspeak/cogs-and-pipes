extends Building
class_name Pipe

@export var holes_l: bool
@export var holes_r: bool
@export var holes_f: bool
@export var holes_b: bool

@export var flow_l: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_r: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_f: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_b: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE

var holes: Dictionary = {
	PIPE_HOLE.SIDE.LEFT: holes_l,
	PIPE_HOLE.SIDE.RIGHT: holes_r,
	PIPE_HOLE.SIDE.FRONT: holes_f,
	PIPE_HOLE.SIDE.BACK: holes_b
	}

var flows: Dictionary = {
	PIPE_HOLE.FLOW_SIDE.LEFT: flow_l,
	PIPE_HOLE.FLOW_SIDE.RIGHT: flow_r,
	PIPE_HOLE.FLOW_SIDE.FRONT: flow_f,
	PIPE_HOLE.FLOW_SIDE.BACK: flow_b
}
