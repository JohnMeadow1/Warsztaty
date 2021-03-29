extends Sprite

var asteroid_object = load("res://scenes/obstacles/asteroid.tscn")
var level

export var max_hit_points = 5.0
export var size = 1.0
var current_hit_points = 0.0

func _ready():
	level    = get_parent().get_parent()
	rotation = rand_range(0, TAU)
	frame    = randi() % 64
	scale    = Vector2( size,  size  )
	current_hit_points = max_hit_points
	
func _on_body_entered(body):
	body.queue_free()
	current_hit_points -= 1
	if current_hit_points <= 0:
		queue_free()
		if randi()% 100 > 49:
			for i in 10:
				level.create_coin( 5, global_position + Vector2.RIGHT.rotated( float(i)/10.0 * TAU ) * rand_range( 30, 60 ) )
				
		level.create_coin( (randi() % 10 + 1) * 5, global_position )
#		if max_hit_points >=2:
#			split( 2 )
		

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage(current_hit_points)
		queue_free()

func split( parts ):
	for i in parts:
		var new_asteroid = asteroid_object.instance()
		new_asteroid.position = position + Vector2.DOWN.rotated( parts/2 - i*2 ) * 32
		new_asteroid.size = size / parts
		new_asteroid.max_hit_points = max_hit_points / parts
		get_parent().add_child(new_asteroid)



