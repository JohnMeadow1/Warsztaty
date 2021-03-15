extends Node2D

onready var background := $background
onready var obstacles := $obstacles

var alien_scene = load("res://scenes/alien.tscn")

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
	
