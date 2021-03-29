extends Node2D
class_name Player

var bullet_scene = preload("res://scenes/bullets/bullet.tscn")
export var move_speed = 500
export var player_id = ""
export var bullet_speed = 400
export var upgrade = 0
export var hit_points = 2

var shoot_timer = 0
var shoot_gun   = 0

onready var gun0 = $Sprite/Gun0
onready var gun1 = $Sprite/Gun1 
onready var gun2 = $Sprite/Gun2 

var cash = 0
onready var GUI = get_parent().get_node("GUI/Cash")

func _ready():
	match player_id:
		"0":
			$Sprite.modulate = Color.white
		"1":
			$Sprite.modulate = Color.green

func _process(delta):
	
	shoot_timer -= delta

	if Input.is_action_pressed("player_"+player_id+"_up"):
		position.y-=move_speed*delta
	if Input.is_action_pressed("player_"+player_id+"_down"):
		position.y+=move_speed*delta
		
	if Input.is_action_pressed("player_"+player_id+"_left"):
		position.x-=move_speed*delta
		$Sprite.rotation -= delta * 5
		
	if Input.is_action_pressed("player_"+player_id+"_right"):
		position.x+=move_speed*delta
		$Sprite.rotation += delta * 5
	
	$Sprite.rotation -= $Sprite.rotation * delta * 10.0
	
	position.x = clamp( position.x, 0, 1024 )
	position.y = clamp( position.y, 0, 600 )

	if shoot_timer <=0 && Input.is_action_pressed( "player_"+player_id+"_shoot" ):
		match upgrade:
			0:
				add_bullet( gun2, Vector2(0,-1).rotated(0.0) )
				shoot_timer = 0.1
			1:
				shoot_3()
			2:
				shoot_5()
			3:
				add_bullet( get_node( "Sprite/Gun"+str(shoot_gun) ) )
				shoot_gun = (shoot_gun + 1) % 3
				shoot_timer = 0.1
			4:
				add_bullet( get_node( "Sprite/Gun" + str( randi() % 3 ) ) )
				shoot_timer = 0.1

func shoot_3():
	add_bullet( get_node( "Sprite/Gun0"), Vector2(0,-1).rotated(-0.3) )
	add_bullet( get_node( "Sprite/Gun2"), Vector2(0,-1) )
	add_bullet( get_node( "Sprite/Gun1"), Vector2(0,-1).rotated(0.3) )
	shoot_timer = 0.2

func shoot_5():
	add_bullet( gun2, Vector2(0,-1).rotated(-0.3) )
	add_bullet( gun2, Vector2(0,-1).rotated(-0.6) )
	add_bullet( gun2, Vector2(0,-1).rotated(0.0), Color(0,1,0) )
	add_bullet( gun2, Vector2(0,-1).rotated(0.3) )
	add_bullet( gun2, Vector2(0,-1).rotated(0.6) )
	shoot_timer = 0.3

func add_bullet( gun, direction = Vector2(0, - 1), color = Color.white ):
	var new_bullet = bullet_scene.instance()
	get_parent().add_child( new_bullet )
	
	new_bullet.velocity = direction * bullet_speed
	new_bullet.global_position = gun.global_position
	new_bullet.modulate = color

func damage( value ):
	hit_points -= value
	if hit_points<= 0:
		queue_free()

func add_coins( value ):
	cash += value
	GUI.text = str(cash)
	

