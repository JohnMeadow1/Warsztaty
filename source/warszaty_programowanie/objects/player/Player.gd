extends Node2D
class_name Player

onready var engine_animator  := $AnimationPlayer
onready var engine_animator2 := $AnimationPlayer2
onready var ship := $body

const ENGINE_THRUST := 1000.0
const ANGULAR_ACCELERATION := 20.0
const VELOCITY_DAMPING := 1.0
const ANGULAT_VELOCITY_DAMPING := 2.5
const mass = 10

# prędkosć
var velocity := Vector2.ZERO
var speed    := 0.0 

var is_thrusting := 0.0 
#var is_braking   := 0.0 

# obrót 
var facing := Vector2.RIGHT
var orientation := 0.0
var anglular_velocity := 0.0

var gravity := Vector2.ZERO
var gravity_direction := Vector2.ZERO

func _ready():
	pass

func _process( delta ):
	process_input( delta )
	
	anglular_velocity -= anglular_velocity * ANGULAT_VELOCITY_DAMPING * delta
	orientation += anglular_velocity * delta
	facing = Vector2( cos(orientation), sin(orientation) )
	
	gravity = Vector2.ZERO
	var distance := 0.0
	for gravity_object in get_tree().get_nodes_in_group("gravity_object"):
		gravity_direction = gravity_object.global_position - global_position
		distance = gravity_direction.length_squared() + pow(gravity_object.radius, 2)
		gravity +=  (mass + gravity_object.mass) / distance * gravity_direction.normalized()
	
	velocity -= velocity * VELOCITY_DAMPING * delta
	
#	if abs(is_thrusting) > 0:
	velocity += (facing * is_thrusting * ENGINE_THRUST + gravity) * delta 
#	elif speed > 0:
#		velocity += (-facing * ENGINE_THRUST * 0.1 + gravity) * delta 
		
	speed = velocity.length()
	position += velocity * delta
	
	ship.rotation = orientation
	
	update()
	
func process_input( delta ):
	is_thrusting = 0
	if Input.is_action_pressed("Player_up"):
		engine_animator.play("engine_thrust")
		engine_animator.seek(0)
		
		engine_animator2.play("engine_thrust")
		is_thrusting = 1

	if Input.is_action_pressed("Player_down"):
		engine_animator.play("engine_thrust_back")
		engine_animator.seek(0)
		is_thrusting = - 0.5

	if Input.is_action_pressed("Player_left"):
		anglular_velocity += - ANGULAR_ACCELERATION * delta

	if Input.is_action_pressed("Player_right"):
		anglular_velocity += ANGULAR_ACCELERATION * delta

func _draw():
	draw_line(Vector2.ZERO, gravity , Color.white, 3 )
	draw_line(Vector2.ZERO, velocity , Color.green, 3 )
	draw_line(Vector2.ZERO, facing * is_thrusting * ENGINE_THRUST, Color.yellow, 3 )
