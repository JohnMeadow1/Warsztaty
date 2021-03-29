extends Area2D

var velocity := Vector2.ZERO
var power    := 1

func _ready():
	pass

func _physics_process( delta ):
	position += velocity * delta
	
	if position.x < -10 or position.x > get_viewport_rect().size.x + 10:
		queue_free()

	if position.y < -10 or position.y > get_viewport_rect().size.y + 10:
		queue_free()

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage( power )
	queue_free()
