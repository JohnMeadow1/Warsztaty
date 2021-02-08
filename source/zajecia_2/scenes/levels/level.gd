extends Node2D

var alien_scene = load("res://scenes/alien.tscn")

func _ready():
	for y in 5:
		for x in 20:
			add_enemy( Vector2(x, y) )

func add_enemy( spawn_position ):
	var new_enemy = alien_scene.instance()
	new_enemy.global_position =  Vector2(100,100) + spawn_position * 44
	add_child( new_enemy )
	
	new_enemy.modulate = Color(spawn_position.x/20.0 , spawn_position.y /5.0, 0)

	
