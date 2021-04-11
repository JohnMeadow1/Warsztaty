extends Sprite
class_name Bullet

var velocity := Vector2.ZERO
var speed    := 0.0
var max_range := 10.0
var distance  := 0.0


func _ready():
	rotation = velocity.angle()


func _process(delta):
	position += velocity * speed * delta
	distance += speed * delta
	if distance >= max_range:
		queue_free()
