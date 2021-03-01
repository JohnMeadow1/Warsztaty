extends Node2D

var hp = 2

func _on_body_entered(body):
	body.queue_free()
	
	damage( 1 )

func damage( value ):
	hp -= value
	if hp <=0:
		queue_free()
