extends Area2D
class_name Turret

var bullet_object = load("res://objects/Bullet.tscn")

var current_target:Enemy
var has_enemy := false
var shoot_delay := 0.1
var timer := 0.0

onready var sprite = $body

func _ready():
	pass
	
func _process(delta):
	timer += delta
	if has_enemy:
		if is_instance_valid(current_target):
			sprite.rotation = (current_target.global_position - global_position).angle()
			if timer >= shoot_delay:
				add_bullet()
				timer = 0
		else:
			has_enemy = false

func add_bullet():
	var new_bullet = bullet_object.instance() as Bullet
	new_bullet.speed = 100
	new_bullet.max_range = 100
	new_bullet.velocity = (current_target.global_position - global_position).normalized()
	add_child(new_bullet)

func _on_area_entered(area):
	if area is Enemy:
		current_target = area
		has_enemy = true
