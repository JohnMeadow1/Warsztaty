extends Node2D

onready var background := $background
onready var obstacles := $obstacles
onready var pickups := $pickups

var alien_scene = load("res://scenes/enemies/alien.tscn")
var coin_object = load("res://scenes/pickups/coin.tscn")

export var travel_speed = 10
export var level_speed = 100

func _ready():
	randomize()
#	generate_alines()
	pass

func generate_alines():
	for y in 5:
		for x in 20:
			add_enemy( Vector2(x, y) )

func add_enemy( spawn_position ):
	var new_enemy = alien_scene.instance()
	new_enemy.global_position =  Vector2(100,100) + spawn_position * 44
	add_child( new_enemy )
	
	new_enemy.modulate = Color(spawn_position.x/20.0 , spawn_position.y /5.0, 0)

func _process(delta):
	background.region_rect.position.y -= travel_speed * delta
	obstacles.position.y += level_speed * delta
	pickups.position.y += level_speed / 2.0 * delta

func create_coin( value, target_position ):
	var new_coin = coin_object.instance()
	new_coin.value = value
#	$pickups.add_child(new_coin)
#	new_coin.global_position = target_position
	$pickups.call_deferred("add_child", new_coin)
	new_coin.global_position = target_position - $pickups.global_position
