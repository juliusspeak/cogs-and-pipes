extends Node3D

var world_cell: Vector3
var cell: Vector2i
var current_building: int:
	set(val):
		current_building = val
		update_plan()
var build_rotation:int = 0

@export var plan: Node3D
var plan_model: Node3D

func _process(delta: float) -> void:
	set_cell()
	draw_plan()

func set_cell() -> void:
		var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
		var cam: Camera3D = GlobalData.camera
		var mousepos: Vector2 = get_viewport().get_mouse_position()
		var origin: Vector3 = cam.project_ray_origin(mousepos)
		var end: Vector3 = origin + cam.project_ray_normal(mousepos) * 200
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		query.collision_mask = 2
		var result = space_state.intersect_ray(query)
		if result:
			world_cell.x = floor(result.position.x / 1.4) * 1.4 + 0.695
			world_cell.y = 0
			world_cell.z = floor(result.position.z / 1.4) * 1.4 + 0.7
			
			world_cell.x = clamp(world_cell.x,-13.305,13.305)
			world_cell.z = clamp(world_cell.z,-11.9,14.7)
			
			var xi: int = floor(remap(floor(world_cell.x),-13.305, 13.305, 19, 0))
			var yi: int = floor(remap(floor(world_cell.z),-11.9, 14.7, 19, 0))
			cell.x = xi
			cell.y = yi

func build() -> void:
	var levelMapController = GlobalData.levelMapController
	var current_lvl_map = levelMapController.current_lvl_map
	
	if current_lvl_map.blocked_cells.has(Vector2i(cell.y,cell.x)):
		return
	
	current_lvl_map.map[cell.y][cell.x] = current_building
	current_lvl_map.rotation[cell.y][cell.x] = build_rotation
	levelMapController.update_map()
	
	

func update_plan() -> void:
	for n in plan.get_children():
		n.queue_free()
		plan_model = null
	
	var res_link: String = BUILDING_RES.get_link(current_building)
	if res_link != "":
		var build = ResourceLoader.load(res_link).instantiate()
		plan.add_child(build)
		plan_model = build
		plan_model.rotation_degrees.y += build_rotation


func draw_plan() -> void:
	if plan_model == null:
		return
	
	plan_model.global_position = world_cell

func rotate_build(val: int) -> void:
	build_rotation += val
	if build_rotation > 270:
		build_rotation = 0
	if build_rotation < -270:
		build_rotation = 0
	
	if plan_model:
		plan_model.rotation_degrees.y += val
