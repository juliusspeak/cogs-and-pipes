extends Node3D
class_name LevelMapController

var current_lvl_map: LevelMap

func _ready() -> void:
	GlobalData.levelMapController = self
	load_lvl(ResourceLoader.load("res://assets/maps/0.tres"))

func clear_lvl() -> void:
	for n in get_children():
		n.free()

func load_lvl(lvl_map: LevelMap) -> void:
	clear_lvl()
	current_lvl_map = lvl_map
	build_map()
	
	update_neighbours()
	
	update_transmissions()

func update_neighbours() -> void:
	for b in get_children():
		b.set_neighbours()

func update_map() -> void:
	load_lvl(current_lvl_map)

func build_map() -> void:
	var x: float = 0
	var z: float = 0
	var row = 0
	var column = 0
	for line in current_lvl_map.map:
		for bld_num in line:
			var build_rotation:int = current_lvl_map.rotation[row][column]
			var res_link: String = BUILDING_RES.get_link(bld_num)
			
			if res_link != "":
				var build: Building = ResourceLoader.load(res_link).instantiate()
				add_child(build)
				build.position = Vector3(-x,0,-z)
				build.pos_in_map = Vector2i(column,row)
				build.rotate_build(build_rotation)
				
			x += 1.4
			
			column += 1
		x = 0
		z += 1.4
		
		row += 1
		column = 0

func get_building_by_pos(pos: Vector2i) -> Building:
	var bld: Building = null
	for b in get_children():
		if b.pos_in_map == pos:
			bld = b
	return bld

func has_transmission_bond(b1: Building, b2: Building) -> Array:
	var arr: Array = []
	var temp_arr: Array = []
	
	if b1 == null or b2 == null:
		return []
	
	if b1.neighbours.values().has(b2):
		if b1.l_neighbour == b2:
			append_big_or_given_trans(temp_arr, b1, b1.l_transmission)
			append_big_or_given_trans(temp_arr, b2, b2.r_transmission)
		if b1.f_neighbour == b2:
			append_big_or_given_trans(temp_arr, b1, b1.f_transmission)
			append_big_or_given_trans(temp_arr, b2, b2.b_transmission)
		if b1.r_neighbour == b2:
			append_big_or_given_trans(temp_arr, b1, b1.r_transmission)
			append_big_or_given_trans(temp_arr, b2, b2.l_transmission)
		if b1.b_neighbour == b2:
			append_big_or_given_trans(temp_arr, b1, b1.b_transmission)
			append_big_or_given_trans(temp_arr, b2, b2.f_transmission)
	
	for i in temp_arr:
		if i != null:
			arr.append(i)
	
	if arr.size() == 2 and arr[0].type == arr[1].type:
		return arr
	else:
		return []

func append_big_or_given_trans(arr: Array, build, trans: Transmission) -> void:
	if build.big_transmission != null:
		arr.append(build.big_transmission)
	else:
		arr.append(trans)

func start_transmission(arr: Array) -> void:
	if arr[0].rotate_direction == arr[1].rotate_direction:
		arr[0].set_rotate_dir(ROTATE_DIRECTION.TYPE.NONE)
		return
		
	if arr[0].rotate_direction == ROTATE_DIRECTION.TYPE.NONE and arr[1].rotate_direction != ROTATE_DIRECTION.TYPE.NONE:
		set_opposite_dir_from_to(arr[1], arr[0])
		
	elif arr[0].rotate_direction != ROTATE_DIRECTION.TYPE.NONE and arr[1].rotate_direction == ROTATE_DIRECTION.TYPE.NONE:
		set_opposite_dir_from_to(arr[0], arr[1])

func set_opposite_dir_from_to(from: Transmission, to: Transmission) -> void:
		if from.rotate_direction == ROTATE_DIRECTION.TYPE.CW:
			to.set_rotate_dir(ROTATE_DIRECTION.TYPE.CCW)
		else:
			to.set_rotate_dir(ROTATE_DIRECTION.TYPE.CW)

func update_transmissions() -> void:
	var need_visit: Array = []
	var visited: Array = []
	need_visit.append(get_building_by_pos(Vector2i(0,9)))
	
	while need_visit.size() > 0:
		var building = need_visit.pop_front()
		visited.append(building)
		if building != null:
			for n in building.neighbours:
					var neighbour = building.neighbours[n]
					if !visited.has(neighbour):
						need_visit.append(neighbour)
						
						var bond_transmissions = has_transmission_bond(building,neighbour)
						
						if bond_transmissions != []:
							start_transmission(bond_transmissions)
