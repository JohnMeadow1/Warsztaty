extends Node2D

var value = 1
var player
var velocity = Vector2.ZERO

func _ready():
	$Sprite/Label.text = str( value )
	$Sprite.self_modulate = Color.from_hsv( float(value) / 50.0, 1, 1 )
	$AnimationPlayer.seek( rand_range(0, 1.2) )
	set_physics_process(false)
	
func _physics_process(delta):
	velocity += (player.global_position - global_position).normalized() * 600 * delta
	velocity -= 2 * velocity  * delta
	global_position += velocity * delta

func _on_area_entered(area):
	if area.has_method("add_coins"):
		area.add_coins( value )
		queue_free()

func _on_magnet_area_entered(area):
	if area is Player:
		player = area
		set_physics_process(true)

func _on_magnet_area_exited(area):
	if area is Player:
		set_physics_process(false)
		velocity = Vector2.ZERO
