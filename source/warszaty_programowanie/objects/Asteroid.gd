extends Node2D

export var mass = 1000
export var radius = 32

func _ready():
	add_to_group("gravity_object")
