extends Node3D
class_name Building

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
	NEIGHBOURS.SIDE.RIGHT: r_neighbour,
	NEIGHBOURS.SIDE.FRONT: f_neighbour,
	NEIGHBOURS.SIDE.BACK: b_neighbour,
}

var transmissions: Dictionary = {
	TRANSMISSIONS.SIDE.LEFT: l_transmission,
	TRANSMISSIONS.SIDE.RIGHT: r_transmission,
	TRANSMISSIONS.SIDE.FRONT: f_transmission,
	TRANSMISSIONS.SIDE.BACK: b_transmission,
	TRANSMISSIONS.SIDE.BIG: big_transmission
}

func rotate_90() -> void:
	var buffer
	
