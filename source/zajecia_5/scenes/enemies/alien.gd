extends Node2D

export var max_hit_points = 2.0
var current_hit_points = 0.0

var falling = false
var timer = 0.0

func _ready():
	current_hit_points = max_hit_points

func _physics_process(delta):
	if falling:
		timer += delta
		position.y += 300 * delta
		position.x += sin(position.y /300.0)*10
	else:
		if randi() % 30000 == 0:
			falling = true

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage( 1 )
	
func damage( value ):
	current_hit_points -= value
	if current_hit_points <= 0:
		queue_free()
