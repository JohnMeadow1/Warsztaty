extends Node2D

onready var background := $background
onready var obstacles := $obstacles
onready var pickups := $pickups

var asteroid_scene = load("res://scenes/obstacles/asteroid.tscn")
var alien_scene = load("res://scenes/enemies/alien.tscn")
var coin_object = load("res://scenes/pickups/coin.tscn")

var wave_data = [0, 50, 100, 150]
var wave_size = [9, 9, 9, 9]
var wave_nr   = 0
var wave_enemy_count = 0
var wave_enemy_timer = 0.0

var traveld_distance    = 0.0
export var travel_speed = 10
export var level_speed  = 100

func _ready():
	randomize()
#	generate_alines()
	generate_asteroids()

func _process(delta):
	background.region_rect.position.y -= travel_speed * delta
	obstacles.position.y += level_speed * delta
	pickups.position.y += level_speed / 2.0 * delta
	
	traveld_distance += travel_speed * delta
	if wave_nr < wave_data.size():
		if traveld_distance > wave_data[wave_nr]:
			if wave_enemy_timer > 0.1:
				generate_wave()
				wave_enemy_timer = 0.0
			else:
				wave_enemy_timer += delta

func generate_alines():
	for y in 5:
		for x in 20:
			add_enemy( Vector2(x, y) )

func generate_wave():
	if wave_enemy_count >= wave_size[wave_nr]:
		wave_nr += 1
		wave_enemy_count = 0
	else:
		add_enemy( Vector2(wave_enemy_count * 100 + 100, -100 ) )
		wave_enemy_count += 1
		wave_enemy_timer = 0


func generate_asteroids():
	var offset_y = 0;
	for i in 100:
		var obstacle_size = (randi() % 3 + 1) 
		offset_y += rand_range(0,64)
		var obstacle_position = Vector2(rand_range(64, 960), -100 -i * 64 -offset_y )
		add_asteroid( obstacle_position, obstacle_size )

func add_asteroid( spawn_position, spawn_size ):
	var new_obstacle = asteroid_scene.instance()
	new_obstacle.global_position = spawn_position - $obstacles.global_position
	new_obstacle.size = spawn_size * 0.5
	new_obstacle.max_hit_points = spawn_size
	$obstacles.call_deferred("add_child", new_obstacle)
	
func add_enemy( spawn_position ):
	var new_enemy = alien_scene.instance()
	new_enemy.global_position = spawn_position
	add_child( new_enemy )
	
#	new_enemy.modulate = Color(spawn_position.x/20.0 , spawn_position.y /5.0, 0)


func create_coin( value, spawn_position ):
	var new_coin = coin_object.instance()
	new_coin.value = value
#	$pickups.add_child(new_coin)
#	new_coin.global_position = spawn_position
	$pickups.call_deferred("add_child", new_coin)
	new_coin.global_position = spawn_position - $pickups.global_position
