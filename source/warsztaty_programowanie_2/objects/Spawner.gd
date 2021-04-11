extends Node2D

var enemy_object := load("res://objects/Enemy.tscn")

export(Array) var waves_count := [5, 10, 20, 20]
export(Array) var waves_hp    := [10, 20, 10, 1]
export(Array) var waves_speed := [100, 50, 300, 100]

var current_wave := 0
var spawn_complete := false
var spawned_count := 0

var spawn_point := Vector2.ZERO

var timer := 0.0

func _ready():
	pass

func _process(delta):
	timer += delta
	if not spawn_complete:
		timer += delta
		if timer >= float(waves_count[current_wave])/waves_speed[current_wave]*20.0:
			spawn_enemy()
			spawned_count += 1
			timer = 0.0
		
		if spawned_count >= waves_count[current_wave]:
			spawn_complete = true
			
	if spawn_complete and get_child_count() <= 0:
		if waves_count.size() > current_wave:
			current_wave += 1
			spawned_count = 0
			spawn_complete = false


func spawn_enemy():
	var new_enemy = enemy_object.instance() as Enemy
	new_enemy.global_position = spawn_point
	new_enemy.hit_points = waves_hp[current_wave]
	new_enemy.speed = waves_speed[current_wave]
	add_child(new_enemy)
	new_enemy.map = get_parent()
