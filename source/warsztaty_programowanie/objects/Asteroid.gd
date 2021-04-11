extends Node2D
class_name Asteroid

export var mass = 1000
export var radius = 32

func _ready():
	add_to_group("gravity_object")

func _on_area_entered(area):
	modulate.r -= 0.1
	if modulate.r <= 0.0 :
		queue_free()
