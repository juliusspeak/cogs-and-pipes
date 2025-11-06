extends Node3D
class_name Building

var pos_in_map: Vector2i
var l_neighbour: Building
var r_neighbour: Building
var f_neighbour: Building
var b_neighbour: Building

@export var big_transmission: Transmission
@export var l_transmission: Transmission
@export var r_transmission: Transmission
@export var f_transmission: Transmission
@export var b_transmission: Transmission

var neighbours: Dictionary = {
	NEIGHBOURS.SIDE.LEFT: l_neighbour,
	NEIGHBOURS.SIDE.FRONT: f_neighbour,
	NEIGHBOURS.SIDE.RIGHT: r_neighbour,
	NEIGHBOURS.SIDE.BACK: b_neighbour,
}

var transmissions: Dictionary = {
	TRANSMISSIONS.SIDE.LEFT: l_transmission,
	TRANSMISSIONS.SIDE.FRONT: f_transmission,
	TRANSMISSIONS.SIDE.RIGHT: r_transmission,
	TRANSMISSIONS.SIDE.BACK: b_transmission,
	TRANSMISSIONS.SIDE.BIG: big_transmission
}

func update_dicts() -> void:
	neighbours = {
		NEIGHBOURS.SIDE.LEFT: l_neighbour,
		NEIGHBOURS.SIDE.FRONT: f_neighbour,
		NEIGHBOURS.SIDE.RIGHT: r_neighbour,
		NEIGHBOURS.SIDE.BACK: b_neighbour,
	}
	transmissions = {
		TRANSMISSIONS.SIDE.LEFT: l_transmission,
		TRANSMISSIONS.SIDE.FRONT: f_transmission,
		TRANSMISSIONS.SIDE.RIGHT: r_transmission,
		TRANSMISSIONS.SIDE.BACK: b_transmission,
		TRANSMISSIONS.SIDE.BIG: big_transmission
	}

func _ready() -> void:
	update_dicts()
	for t in transmissions:
		connect_transmission(transmissions[t])

func connect_transmission(trans) -> void:
	if trans != null:
		if !trans.rotate_direction_changed.is_connected(change_rotate_direction):
			trans.rotate_direction_changed.connect(change_rotate_direction)

func stop_all_transmissions() -> void:
	for t in transmissions:
		stop_transmission(transmissions[t])

func stop_transmission(trans) -> void:
	if trans != null:
		trans.rotate_direction = ROTATE_DIRECTION.TYPE.NONE

func change_rotate_direction(trans: Transmission) -> void:
	
	if trans.rotate_direction == ROTATE_DIRECTION.TYPE.NONE:
		stop_all_transmissions()
		return
	
	var opposite
	var direct
	if trans.revers == false:
		if trans.rotate_direction == ROTATE_DIRECTION.TYPE.CW:
			opposite = ROTATE_DIRECTION.TYPE.CCW
			direct = ROTATE_DIRECTION.TYPE.CW
		else:
			opposite = ROTATE_DIRECTION.TYPE.CW
			direct = ROTATE_DIRECTION.TYPE.CCW
	else:
		if trans.rotate_direction == ROTATE_DIRECTION.TYPE.CW:
			opposite = ROTATE_DIRECTION.TYPE.CW
			direct = ROTATE_DIRECTION.TYPE.CCW
		else:
			opposite = ROTATE_DIRECTION.TYPE.CCW
			direct = ROTATE_DIRECTION.TYPE.CW
	
	
	match trans:
		l_transmission: 
			set_trans_type(f_transmission, opposite)
			set_trans_type(r_transmission, direct)
			set_trans_type(b_transmission, opposite)
		r_transmission:
			set_trans_type(f_transmission, opposite)
			set_trans_type(l_transmission, direct)
			set_trans_type(b_transmission, opposite)
		f_transmission:
			set_trans_type(l_transmission, opposite)
			set_trans_type(b_transmission, direct)
			set_trans_type(r_transmission, opposite)
		b_transmission:
			set_trans_type(l_transmission, opposite)
			set_trans_type(f_transmission, direct)
			set_trans_type(r_transmission, opposite)

func set_trans_type(transmission: Transmission, trans) -> void:
	if transmission == null:
		return
	transmission.rotate_direction = trans

func set_neighbours() -> void:
	var x: int = pos_in_map.x
	var y: int = pos_in_map.y
	var lvlMapControl = GlobalData.levelMapController
	
	l_neighbour = lvlMapControl.get_building_by_pos(Vector2i(x-1,y))
	f_neighbour = lvlMapControl.get_building_by_pos(Vector2i(x,y-1))
	r_neighbour = lvlMapControl.get_building_by_pos(Vector2i(x+1,y))
	b_neighbour = lvlMapControl.get_building_by_pos(Vector2i(x,y+1))
	update_dicts()

func rotate_vals_in_sides(dict: Dictionary, dir:ROTATE_DIRECTION.TYPE) -> Dictionary:
	var new_dict: Dictionary
	match dir:
		ROTATE_DIRECTION.TYPE.CW:
			new_dict = {
				NEIGHBOURS.SIDE.LEFT: dict[NEIGHBOURS.SIDE.BACK],
				NEIGHBOURS.SIDE.FRONT: dict[NEIGHBOURS.SIDE.LEFT],
				NEIGHBOURS.SIDE.RIGHT: dict[NEIGHBOURS.SIDE.FRONT],
				NEIGHBOURS.SIDE.BACK: dict[NEIGHBOURS.SIDE.RIGHT],
			}
		ROTATE_DIRECTION.TYPE.CCW:
			new_dict = {
				NEIGHBOURS.SIDE.LEFT: dict[NEIGHBOURS.SIDE.FRONT],
				NEIGHBOURS.SIDE.FRONT: dict[NEIGHBOURS.SIDE.RIGHT],
				NEIGHBOURS.SIDE.RIGHT: dict[NEIGHBOURS.SIDE.BACK],
				NEIGHBOURS.SIDE.BACK: dict[NEIGHBOURS.SIDE.LEFT],
			}
	return new_dict

func rotate_build(val: int) -> void:
	var count: int = abs(int(val / 90))
	for i in count:
		var new_neighbours: Dictionary
		var new_l_t
		var new_f_t
		var new_r_t
		var new_b_t
		
		if val > 0:
			new_neighbours = rotate_vals_in_sides(neighbours,ROTATE_DIRECTION.TYPE.CW)
			
			new_l_t = f_transmission
			new_f_t = r_transmission
			new_r_t = b_transmission
			new_b_t = l_transmission
		else:
			new_neighbours = rotate_vals_in_sides(neighbours,ROTATE_DIRECTION.TYPE.CCW)
			new_l_t = b_transmission
			new_f_t = l_transmission
			new_r_t = f_transmission
			new_b_t = r_transmission
			
		neighbours = new_neighbours
		l_transmission = new_l_t
		f_transmission = new_f_t
		r_transmission = new_r_t
		b_transmission = new_b_t
	update_dicts()
	rotation_degrees.y += val
	
	GlobalData.levelMapController.update_neighbours()
