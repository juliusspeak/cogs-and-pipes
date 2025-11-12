extends Building
class_name Pipe

@export var water_particle_l: CPUParticles3D
@export var water_particle_f: CPUParticles3D
@export var water_particle_r: CPUParticles3D
@export var water_particle_b: CPUParticles3D

@export var hole_l: bool
@export var hole_f: bool
@export var hole_r: bool
@export var hole_b: bool

@export var flow_l: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_f: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_r: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE
@export var flow_b: PIPE_HOLE.FLOW = PIPE_HOLE.FLOW.NONE

var flow_strength: int = 0

var particles: Dictionary = {
	PIPE_HOLE.SIDE.LEFT: water_particle_l,
	PIPE_HOLE.SIDE.FRONT:water_particle_f,
	PIPE_HOLE.SIDE.RIGHT:water_particle_r,
	PIPE_HOLE.SIDE.BACK: water_particle_b
}
var holes: Dictionary = {
	PIPE_HOLE.SIDE.LEFT: hole_l,
	PIPE_HOLE.SIDE.FRONT: hole_f,
	PIPE_HOLE.SIDE.RIGHT: hole_r,
	PIPE_HOLE.SIDE.BACK: hole_b
	}

var flows: Dictionary = {
	PIPE_HOLE.SIDE.LEFT: flow_l,
	PIPE_HOLE.SIDE.FRONT: flow_f,
	PIPE_HOLE.SIDE.RIGHT: flow_r,
	PIPE_HOLE.SIDE.BACK: flow_b
}

func update_dicts() -> void:
	holes = {
		PIPE_HOLE.SIDE.LEFT: hole_l,
		PIPE_HOLE.SIDE.FRONT: hole_f,
		PIPE_HOLE.SIDE.RIGHT: hole_r,
		PIPE_HOLE.SIDE.BACK: hole_b
	}
	flows = {
		PIPE_HOLE.SIDE.LEFT: flow_l,
		PIPE_HOLE.SIDE.FRONT: flow_f,
		PIPE_HOLE.SIDE.RIGHT: flow_r,
		PIPE_HOLE.SIDE.BACK: flow_b
	}
	particles = {
		PIPE_HOLE.SIDE.LEFT: water_particle_l,
		PIPE_HOLE.SIDE.FRONT:water_particle_f,
		PIPE_HOLE.SIDE.RIGHT:water_particle_r,
		PIPE_HOLE.SIDE.BACK: water_particle_b
	}
	super.update_dicts()

func rotate_vals_in_pipes(dict: Dictionary, dir:ROTATE_DIRECTION.TYPE) -> Dictionary:
	var new_dict: Dictionary
	match dir:
		ROTATE_DIRECTION.TYPE.CW:
			new_dict = {
				PIPE_HOLE.SIDE.LEFT: dict[PIPE_HOLE.SIDE.BACK],
				PIPE_HOLE.SIDE.FRONT: dict[PIPE_HOLE.SIDE.LEFT],
				PIPE_HOLE.SIDE.RIGHT: dict[PIPE_HOLE.SIDE.FRONT],
				PIPE_HOLE.SIDE.BACK: dict[PIPE_HOLE.SIDE.RIGHT],
			}
		ROTATE_DIRECTION.TYPE.CCW:
			new_dict = {
				PIPE_HOLE.SIDE.LEFT: dict[PIPE_HOLE.SIDE.FRONT],
				PIPE_HOLE.SIDE.FRONT: dict[PIPE_HOLE.SIDE.RIGHT],
				PIPE_HOLE.SIDE.RIGHT: dict[PIPE_HOLE.SIDE.BACK],
				PIPE_HOLE.SIDE.BACK: dict[PIPE_HOLE.SIDE.LEFT],
			}
	return new_dict

func rotate_build(val: int) -> void:
	super.rotate_build(val)
	
	var count: int = abs(int(val / 90))
	for i in count:
		var new_flows: Dictionary
		var new_holes: Dictionary
		var new_particles: Dictionary
		if val > 0:
			new_flows = rotate_vals_in_pipes(flows,ROTATE_DIRECTION.TYPE.CW)
			new_holes = rotate_vals_in_pipes(holes,ROTATE_DIRECTION.TYPE.CCW)
			new_particles = rotate_vals_in_pipes(particles,ROTATE_DIRECTION.TYPE.CCW)
		else:
			new_flows = rotate_vals_in_pipes(flows,ROTATE_DIRECTION.TYPE.CCW)
			new_holes = rotate_vals_in_pipes(holes,ROTATE_DIRECTION.TYPE.CW)
			new_particles = rotate_vals_in_pipes(particles,ROTATE_DIRECTION.TYPE.CW)
		flows = new_flows
		holes = new_holes
		particles = new_particles
	
	hole_l = holes[PIPE_HOLE.SIDE.LEFT]
	hole_f = holes[PIPE_HOLE.SIDE.FRONT]
	hole_r = holes[PIPE_HOLE.SIDE.RIGHT]
	hole_b = holes[PIPE_HOLE.SIDE.BACK]
	
	flow_l = flows[PIPE_HOLE.SIDE.LEFT]
	flow_f = flows[PIPE_HOLE.SIDE.FRONT]
	flow_r = flows[PIPE_HOLE.SIDE.RIGHT]
	flow_b = flows[PIPE_HOLE.SIDE.BACK]
	
	water_particle_l = particles[PIPE_HOLE.SIDE.LEFT]
	water_particle_f = particles[PIPE_HOLE.SIDE.FRONT]
	water_particle_r = particles[PIPE_HOLE.SIDE.RIGHT]
	water_particle_b = particles[PIPE_HOLE.SIDE.BACK]
	update_dicts()

func sync_pipe_exports(pipe: Pipe) -> void:
	pipe.flow_l = pipe.flows[PIPE_HOLE.SIDE.LEFT]
	pipe.flow_f = pipe.flows[PIPE_HOLE.SIDE.FRONT]
	pipe.flow_r = pipe.flows[PIPE_HOLE.SIDE.RIGHT]
	pipe.flow_b = pipe.flows[PIPE_HOLE.SIDE.BACK]
	pipe.update_dicts()
