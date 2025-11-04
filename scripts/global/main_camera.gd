extends Camera3D

var offset: Vector3
var distance: float = 40

var start_rotation_x: float
var start_rotation_y: float
var target_rotation_x: float
var target_rotation_y: float
var rotation_x: float  = 0.0
var rotation_y: float = 0.0

var target: Node3D
var target_pos: Vector3
var input_vector: Vector3

var locked: bool = false

func _ready() -> void:
	start_rotation_x = -rotation.x
	start_rotation_y = -rotation.y
	target_rotation_x = start_rotation_x
	target_rotation_y = start_rotation_y
	rotation_x = start_rotation_x
	rotation_y = start_rotation_y
	offset = global_position
	target_pos = Vector3.ZERO
	
	GlobalData.camera = self

func set_target(target_node: Node3D) -> void:
	target = target_node

func reset_pos() -> void:
	target_pos = Vector3.ZERO
	target_rotation_x  = start_rotation_x
	target_rotation_y = start_rotation_y
	distance = 40

func _process(delta: float) -> void:
	
	rotation_x = lerp(rotation_x, target_rotation_x, 0.02)
	rotation_y = lerp(rotation_y, target_rotation_y, 0.05)
	var dir = Vector3(
		sin(rotation_y) * cos(rotation_x),
		sin(rotation_x),
		cos(rotation_y) * cos(rotation_x)
	).normalized()
	
	global_position = target_pos + dir * distance
	look_at(target_pos, Vector3.UP)
	var forward = global_transform.basis.z
	forward.y = 0
	forward = forward.normalized()
	
	var right = global_transform.basis.x
	right.y = 0
	right = right.normalized()
	
	var move_dir = forward * input_vector.z + right * input_vector.x
	move_dir = move_dir.normalized() if move_dir.length() > 0 else Vector3.ZERO
	
	target_pos.x = min(10,target_pos.x,)
	target_pos.x = max(-10,target_pos.x,)
	target_pos.z = min(8,target_pos.z,)
	target_pos.z = max(-8,target_pos.z,)
	
	target_pos = lerp(target_pos, target_pos + move_dir, 0.1)

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		target_rotation_y -= event.relative.x * 0.01
		
		var delta_x = event.relative.y * 0.01
		target_rotation_x = clamp(target_rotation_x + delta_x, 0.83, 1.5)
	
	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance = max(10, distance - 5.0)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance = min(40.0, distance + 5.0)
	
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	input_vector = input_vector.normalized()


func _on_button_pressed() -> void:
	reset_pos()
