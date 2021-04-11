extends Node2D
class_name Enemy

export var debug := false

var speed := 30.0
var hit_points := 1.0
var size = 0.0

var facing := Vector2.LEFT

onready var sprite := $fighter
var map :GameMap

func _ready():
	size = $CollisionShape2D.shape.radius

func _process(delta):
	position += facing * speed * delta
	sprite.rotation = lerp_angle( sprite.rotation, facing.angle(), 0.2 )

	if not map.get_coordinates(position + facing * 32):
		if not map.get_coordinates(position + facing.rotated(PI/2.0) * 64):
			facing = facing.tangent()
		else:
			facing = -facing.tangent()

	if debug:
		$Label.visible = true
		$Label.text = str((( position ) / 64).floor() )
		$Label.text += "\n"+str(map.get_coordinates(position))

func _on_area_entered(area):
	if area is Headquarters:
		queue_free()

func damage(value):
	hit_points -= value
	if hit_points <= 0:
		queue_free()
		
		
		
