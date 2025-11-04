extends Node3D

var world_cell: Vector3
var cell: Vector2i
var current_building: int

	
func _process(delta: float) -> void:
	set_cell()

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
	GlobalData.levelMapLoader.current_lvl_map.map[cell.y][cell.x] = current_building
	GlobalData.levelMapLoader.update_map()
