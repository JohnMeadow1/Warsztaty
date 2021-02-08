extends Node2D

var bullet_scene = preload("res://Bullet.tscn")
export var move_speed = 500
export var player_id = ""

var shoot_timer = 0

func _ready():
	pass

func _process(delta):
	
	shoot_timer -= delta
	
	if Input.is_action_pressed("ui_up"+player_id):
		position.y-=move_speed*delta
	if Input.is_action_pressed("ui_down"+player_id):
		position.y+=move_speed*delta
		
	if Input.is_action_pressed("ui_left"+player_id):
		position.x-=move_speed*delta
		$Sprite.rotation -= delta * 5
		
	if Input.is_action_pressed("ui_right"+player_id):
		position.x+=move_speed*delta
		$Sprite.rotation += delta * 5
	
	$Sprite.rotation -= $Sprite.rotation * delta * 10.0
	
	position.x = clamp( position.x, 0, 1024 )
	position.y = clamp( position.y, 0, 600 )

	if shoot_timer <=0 && Input.is_action_pressed( "ui_select" + player_id ):
		var new_bullet = bullet_scene.instance()
		get_parent().add_child( new_bullet )
		
#		new_bullet.linear_velocity.x += rand_range( -50, 50 )
		new_bullet.global_position = global_position
		
		shoot_timer = 0.2

func _physics_process(delta):
	pass
