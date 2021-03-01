extends RigidBody2D

func _ready():
	pass

func _on_Bullet_body_entered(body):
	queue_free()

func _on_Timer_timeout():
	queue_free()
