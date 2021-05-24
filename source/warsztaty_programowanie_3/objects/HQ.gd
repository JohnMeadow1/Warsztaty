extends Area2D
class_name Headquarters

export(int)var HitPoints = 10

onready var sprite = $Sprite

func register_on_map():
	pass

func _on_area_entered( area ):
	HitPoints -= 1
	sprite.modulate.g -= 0.1
	sprite.modulate.b -= 0.1
	if HitPoints <= 0:
		queue_free()
