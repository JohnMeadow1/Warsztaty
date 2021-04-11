extends Node2D

onready var engine_animator  := $AnimationPlayer
onready var engine_animator2 := $AnimationPlayer2
onready var ship := $body

const ENGINE_THRUST := 100.0
const ANGULAR_ACCELERATION := 10.0

# prędkosć
var velocity := Vector2.ZERO
var speed    := 0.0 

var is_thrusting := 0.0 

# obrót 
var facing := Vector2.RIGHT
var orientation := 0.0
var anglular_velocity := 0.0

func _ready():
	pass

func _process( delta ):
	process_input( delta )
	
	orientation += anglular_velocity * delta
	facing = Vector2( cos(orientation), sin(orientation) )
	
	velocity += facing * is_thrusting * ENGINE_THRUST * delta
	position += velocity * delta
	
	ship.rotation = orientation
	
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

