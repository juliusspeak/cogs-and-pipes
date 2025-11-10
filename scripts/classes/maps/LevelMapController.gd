extends Node3D
class_name LevelMapController

signal level_loaded

var current_lvl_map: LevelMap
var levels: Array
signal level_passed

func _ready() -> void:
	GlobalData.levelMapController = self
	Util.set_file_paths_to_arr("res://assets/maps/","tres",levels)
	levels.reverse()
	GlobalData.state_changed.connect(change_state)

func change_state(state: GlobalData.STATE):
	match state:
		GlobalData.STATE.MENU:
			pass
		GlobalData.STATE.LEVELSELECT:
			pass
		GlobalData.STATE.LOADGAME:
			load_lvl(current_lvl_map)
		GlobalData.STATE.LOADEDITOR:
			load_lvl(LevelMap.new())

func clear_lvl() -> void:
	for n in get_children():
		n.free()

func load_next() -> void:
	var lvl_num = levels.find(str(current_lvl_map.resource_path))
	if levels.size()-1 >= lvl_num + 1 and lvl_num != -1:
		current_lvl_map = ResourceLoader.load(levels[lvl_num+1])
		GlobalData.current_state = GlobalData.STATE.LOADGAME

func load_lvl(lvl_map: LevelMap) -> void:
	clear_lvl()
	current_lvl_map = lvl_map
	build_map()
	
	update_neighbours()
	update_transmissions()
	update_flows()
	
	if GlobalData.current_state == GlobalData.STATE.EDITOR or GlobalData.current_state == GlobalData.STATE.LOADEDITOR:
		Visuals.show_locked_cells(current_lvl_map)
		Visuals.show_goal_cells(current_lvl_map)
	elif GlobalData.current_state == GlobalData.STATE.LOADGAME or GlobalData.current_state == GlobalData.STATE.GAME:
		check_win_conditions()
	
	if GlobalData.current_state == GlobalData.STATE.LOADGAME:
		GlobalData.current_state = GlobalData.STATE.GAME
	if GlobalData.current_state == GlobalData.STATE.LOADEDITOR:
		GlobalData.current_state = GlobalData.STATE.EDITOR
	level_loaded.emit()

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
	
func get_building_by_res_id(res_id: int) -> Array:
	var arr: Array
	var x: int = 0
	var y: int = 0
	for row in current_lvl_map.map:
		for column in row:
			if current_lvl_map.map[x][y] == res_id:
				arr.append(get_building_by_pos(Vector2i(y,x)))
			y += 1
		x += 1
		y = 0
	return arr

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
	var need_visit: Array
	var visited: Array
	need_visit.append(get_building_by_pos(Vector2i(0,9)))
	
	while need_visit.size() > 0:
		var building: Building = need_visit.pop_front()
		
		visited.append(building)
		if building != null:
			for side in building.neighbours:
				var count: int = building.neighbours.keys()[side]
				var has_transmission_on_side: bool = false
				if building.transmissions[count] != null:
					has_transmission_on_side = true
				if building.big_transmission != null:
					has_transmission_on_side = true
					
				if has_transmission_on_side == true:
					var neighbour = building.neighbours[side]
					if !visited.has(neighbour):
						
						need_visit.append(neighbour)
						
						var bond_transmissions = has_transmission_bond(building,neighbour)
						
						if bond_transmissions != []:
							start_transmission(bond_transmissions)

func def_pump_dir(pump: Pipe):
	for h in pump.holes:
		if pump.holes[h] == true:
			return h
func check_pumping(pump: Pipe, dir: PIPE_HOLE.SIDE):
	match dir:
		0:
			if pump.b_transmission.rotate_direction == ROTATE_DIRECTION.TYPE.CCW:
				return true
			else:
				return false
		1:
			if pump.l_transmission.rotate_direction == ROTATE_DIRECTION.TYPE.CCW:
				return true
			else:
				return false
		2:
			if pump.f_transmission.rotate_direction == ROTATE_DIRECTION.TYPE.CCW:
				return true
			else:
				return false
		3:
			if pump.r_transmission.rotate_direction == ROTATE_DIRECTION.TYPE.CCW:
				return true
			else:
				return false

func set_pipe_particle(pipe: Pipe, dir: PIPE_HOLE.SIDE, status: bool) -> void:
	pipe.particles[dir].emitting = status


func set_pipe_flow(pipe: Pipe, dir:PIPE_HOLE.SIDE, type: PIPE_HOLE.FLOW) -> void:
	var particles: bool
	if type == PIPE_HOLE.FLOW.OUT:
		particles = true
	else:
		particles = false
	pipe.flows[dir] = type
	set_pipe_particle(pipe, dir, particles)
	pipe.sync_pipe_exports(pipe)

func pipe_dir_to_neighbour_dir(dir: PIPE_HOLE.SIDE):
	match dir:
		PIPE_HOLE.SIDE.LEFT:
			return NEIGHBOURS.SIDE.LEFT
		PIPE_HOLE.SIDE.FRONT:
			return NEIGHBOURS.SIDE.FRONT
		PIPE_HOLE.SIDE.RIGHT:
			return NEIGHBOURS.SIDE.RIGHT
		PIPE_HOLE.SIDE.BACK:
			return NEIGHBOURS.SIDE.BACK


func update_flows() -> void:
	var need_visit: Array
	var visited: Array
	
	var pumps: Array = get_building_by_res_id(8)
	for pump: Pipe in pumps:
		var dir: PIPE_HOLE.SIDE = def_pump_dir(pump)
		if check_pumping(pump,dir):
			set_pipe_flow(pump,dir,PIPE_HOLE.FLOW.OUT)
			
			var neighbour_dir = pipe_dir_to_neighbour_dir(dir)
			
			
			if pump.neighbours[neighbour_dir] != null and pump.neighbours[neighbour_dir] is Pipe:
				var opposite: PIPE_HOLE.SIDE = Util.get_opposite_dir(dir)
				var pipe: Pipe = pump.neighbours[neighbour_dir]
				
				if pipe.holes[opposite] == true:
					need_visit.append(pipe)
					set_pipe_flow(pipe,opposite,PIPE_HOLE.FLOW.IN)
		else:
			set_pipe_particle(pump, dir, false)
	
	while need_visit.size() > 0:
		var pipe = need_visit.pop_front()
		visited.append(pipe)
		
		for side in pipe.holes:
			if pipe.holes[side] == true and pipe.flows[side] != PIPE_HOLE.FLOW.IN:
				set_pipe_flow(pipe,side,PIPE_HOLE.FLOW.OUT)
				var neighbour
				
				var count: int = pipe.neighbours.keys()[side]
				neighbour = pipe.neighbours[count]
				
				if neighbour != null and neighbour is Pipe:
					
					var opposite: PIPE_HOLE.SIDE = Util.get_opposite_dir(side)
					var new_pipe: Pipe = neighbour
					
					if new_pipe.holes[opposite] == true:
						need_visit.append(new_pipe)
						set_pipe_flow(new_pipe,opposite,PIPE_HOLE.FLOW.IN)

	

func check_win_conditions() -> void:
	var wins: Array
	
	for coord in current_lvl_map.win_cells:
		var pipe_win: bool = false
		var pipe: Pipe = get_building_by_pos(Vector2i(coord.y,coord.x))
		for flow in pipe.flows:
			if pipe.flows[flow] != 0:
				pipe_win = true
		
		var mark_name: String = "connected"
		if pipe_win == true:
			mark_name = "connected"
		elif pipe_win == false:
			mark_name = "disconnected"
		
		Visuals.instantiate_mark(pipe.position + Vector3(0,2,0), mark_name)
		
		wins.append(pipe_win)
	
	for result in wins:
		if result == false:
			return
	
	current_lvl_map.passed = true
	
	level_passed.emit()
