extends Node3D
class_name Transmission

signal rotate_direction_changed
@export var type: TRANSMISSION_TYPE.TYPE
@export var rotate_direction: ROTATE_DIRECTION.TYPE = ROTATE_DIRECTION.TYPE.NONE
@export var rotate_speed: float = 2
@export var revers: bool = false

func _process(delta: float) -> void:
	match type:
		TRANSMISSION_TYPE.TYPE.GEAR:
			match rotate_direction:
				ROTATE_DIRECTION.TYPE.CW:
					rotation_degrees.y += -rotate_speed*70*delta
				ROTATE_DIRECTION.TYPE.CCW:
					rotation_degrees.y += rotate_speed*70*delta
				ROTATE_DIRECTION.TYPE.NONE:
					rotation.y = 0
		TRANSMISSION_TYPE.TYPE.SHAFT:
			match rotate_direction:
				ROTATE_DIRECTION.TYPE.CW:
					rotation_degrees.x += -rotate_speed*70*delta
				ROTATE_DIRECTION.TYPE.CCW:
					rotation_degrees.x += rotate_speed*70*delta
				ROTATE_DIRECTION.TYPE.NONE:
					rotation.x = 0

func set_rotate_dir(val) -> void:
	rotate_direction = val
	rotate_direction_changed.emit(self)
