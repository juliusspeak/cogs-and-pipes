@tool
extends Node3D
class_name Transmission

@export var type: TRANSMISSION_TYPE.TYPE
@export var rotate_direction: ROTATE_DIRECTION.TYPE = ROTATE_DIRECTION.TYPE.NONE
@export var rotate_speed: float = 2

func _process(delta: float) -> void:
	match type:
		TRANSMISSION_TYPE.TYPE.GEAR:
			match rotate_direction:
				ROTATE_DIRECTION.TYPE.CW:
					rotate_y(-rotate_speed*delta)
				ROTATE_DIRECTION.TYPE.CCW:
					rotate_y(rotate_speed*delta)
				ROTATE_DIRECTION.TYPE.NONE:
					rotation.y = 0
		TRANSMISSION_TYPE.TYPE.SHAFT:
			match rotate_direction:
				ROTATE_DIRECTION.TYPE.CW:
					rotate_x(-rotate_speed*delta)
				ROTATE_DIRECTION.TYPE.CCW:
					rotate_x(rotate_speed*delta)
				ROTATE_DIRECTION.TYPE.NONE:
					rotation.x = 0
