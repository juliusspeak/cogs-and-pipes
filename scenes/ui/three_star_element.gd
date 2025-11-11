@tool
extends HBoxContainer
@export var texture_rect: TextureRect
@export var texture_rect_2: TextureRect
@export var texture_rect_3: TextureRect

@export_enum("ZERO","ONE","TWO","THREE") var stars = 0:
	set(vol):
		stars = vol
		if is_node_ready():
			change_stars_count()

func _ready() -> void:
	change_stars_count()

func change_stars_count() -> void:
	match stars:
		0:
			$TextureRect.modulate.a = 0.2
			$TextureRect2.modulate.a = 0.2
			$TextureRect3.modulate.a = 0.2
		1:
			$TextureRect.modulate.a = 1
			$TextureRect2.modulate.a = 0.2
			$TextureRect3.modulate.a = 0.2
		2:
			$TextureRect.modulate.a = 1
			$TextureRect2.modulate.a = 1
			$TextureRect3.modulate.a = 0.2
		3:
			$TextureRect.modulate.a = 1
			$TextureRect2.modulate.a = 1
			$TextureRect3.modulate.a = 1
