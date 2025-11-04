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

func update_dicts() -> void:
	holes = {
		PIPE_HOLE.SIDE.LEFT: holes_l,
		PIPE_HOLE.SIDE.RIGHT: holes_r,
		PIPE_HOLE.SIDE.FRONT: holes_f,
		PIPE_HOLE.SIDE.BACK: holes_b
	}
	flows = {
		PIPE_HOLE.FLOW_SIDE.LEFT: flow_l,
		PIPE_HOLE.FLOW_SIDE.RIGHT: flow_r,
		PIPE_HOLE.FLOW_SIDE.FRONT: flow_f,
		PIPE_HOLE.FLOW_SIDE.BACK: flow_b
	}
	super.update_dicts()

func rotate_build(val: int) -> void:
	super.rotate_build(val)
	
	var count: int = abs(int(val / 90))
	for i in count:
		var new_flows: Dictionary
		var new_holes: Dictionary
		if val > 0:
			new_flows = {
				PIPE_HOLE.FLOW_SIDE.LEFT: flows[PIPE_HOLE.FLOW_SIDE.BACK],
				PIPE_HOLE.FLOW_SIDE.FRONT: flows[PIPE_HOLE.FLOW_SIDE.LEFT],
				PIPE_HOLE.FLOW_SIDE.RIGHT: flows[PIPE_HOLE.FLOW_SIDE.FRONT],
				PIPE_HOLE.FLOW_SIDE.BACK: flows[PIPE_HOLE.FLOW_SIDE.RIGHT],
			}
			new_holes = {
				PIPE_HOLE.SIDE.LEFT: holes[PIPE_HOLE.SIDE.BACK],
				PIPE_HOLE.SIDE.FRONT: holes[PIPE_HOLE.SIDE.LEFT],
				PIPE_HOLE.SIDE.RIGHT: holes[PIPE_HOLE.SIDE.FRONT],
				PIPE_HOLE.SIDE.BACK: holes[PIPE_HOLE.SIDE.RIGHT],
			}
		else:
			new_flows = {
				PIPE_HOLE.FLOW_SIDE.LEFT: neighbours[PIPE_HOLE.FLOW_SIDE.FRONT],
				PIPE_HOLE.FLOW_SIDE.FRONT: neighbours[PIPE_HOLE.FLOW_SIDE.RIGHT],
				PIPE_HOLE.FLOW_SIDE.RIGHT: neighbours[PIPE_HOLE.FLOW_SIDE.BACK],
				PIPE_HOLE.FLOW_SIDE.BACK: neighbours[PIPE_HOLE.FLOW_SIDE.LEFT],
			}
			new_holes = {
				PIPE_HOLE.SIDE.LEFT: holes[PIPE_HOLE.SIDE.FRONT],
				PIPE_HOLE.SIDE.FRONT: holes[PIPE_HOLE.SIDE.RIGHT],
				PIPE_HOLE.SIDE.RIGHT: holes[PIPE_HOLE.SIDE.BACK],
				PIPE_HOLE.SIDE.BACK: holes[PIPE_HOLE.SIDE.LEFT],
			}
		flows = new_flows
		holes = new_holes
	update_dicts()
