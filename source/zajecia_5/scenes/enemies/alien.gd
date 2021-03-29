extends Node2D

var hp = 2

var falling = false
var timer = 0.0

func _on_body_entered(body):
	body.queue_free()
	
	damage( 1 )

func damage( value ):
	hp -= value
	if hp <=0:
		queue_free()
		
func _physics_process(delta):
	if falling:
		timer += delta
		position.y += 300 * delta
		position.x += sin(position.y /300.0)*10
	else:
		if randi() % 300 == 0:
			falling = true
