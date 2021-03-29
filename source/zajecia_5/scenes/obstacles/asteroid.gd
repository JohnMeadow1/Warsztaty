extends Area2D

var asteroid_object = load("res://scenes/obstacles/asteroid.tscn")
var level

export var max_hit_points = 5.0
export var size = 1.0
var current_hit_points = 0.0

onready var sprite = $Sprite

func _ready():
	level    = get_parent().get_parent()
	sprite.rotation = rand_range(0, TAU)
	sprite.frame    = randi() % 64
	sprite.scale    = Vector2( size,  size  )
	current_hit_points = max_hit_points

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage(current_hit_points)

func damage( value ):
	current_hit_points -= value
	if current_hit_points <= 0:
		queue_free()
		generate_loot()

func generate_loot():
	var random_chance = randi()% 100
	if random_chance < 50:
		drop_coins(4, 5)
	elif random_chance < 75:
		drop_coins(4, 2)
	elif random_chance < 90:
		drop_coins(2, 2)
	else:
		drop_coins(2, 1)
	
	level.create_coin( (randi() % 10 + 1) * 5, global_position )


func drop_coins( coins_count, coins_value ):
	for i in coins_count:
		level.create_coin( coins_value, global_position + Vector2.RIGHT.rotated( float(i)/coins_count * TAU ) * 50 )
		
#		level.create_coin( coins_value, global_position + Vector2.RIGHT.rotated( float(i)/coins_count * TAU ) * rand_range( 30, 60 ) )
	
func split( parts ):
	for i in parts:
		var new_asteroid = asteroid_object.instance()
		new_asteroid.position = position + Vector2.DOWN.rotated( parts/2 - i*2 ) * 32
		new_asteroid.size = size / parts
		new_asteroid.max_hit_points = max_hit_points / parts
		get_parent().add_child(new_asteroid)



