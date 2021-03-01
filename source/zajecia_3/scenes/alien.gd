extends Node2D

var hp = 2

func _on_body_entered(body):
	body.queue_free()
	
	hp -= 1
	if hp <=0:
		queue_free()
