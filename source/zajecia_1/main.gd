extends Node2D

var hp = 100
export(int) var max_hp = 500
var text = "iterator = "

onready var hit_points_label = $HP
onready var hit_points_bar = $HP_bar
onready var hit_points_bar2 = $HP_bar2

func _ready():
	hit_points_bar.max_value = max_hp
	hit_points_bar2.max_value = max_hp
#	hp += 1
#	print (text, iterator)
#	print ("iterator = " + str(iterator) )
#	print ("iterator = " + str(hp) )

#	for i in 10:
#		print(i)
#		hit_points_label.text = "HP = " + str(i)
	pass
	
func _process(delta):
	if hp < max_hp:
		update_hp( 1 )

	if Input.is_action_just_pressed("ui_accept"):
		update_hp( -100 )
		
#	if hp % 10 == 0:
#		hit_points_label.text = "HP = " + str(hp)

func update_hp( value ):
	if (hp + value) < 0:
		hp = 0
		$Game_over.text = "GAME OVER"
#		set_process(false)
		get_tree().change_scene("res://scenes/game_over.tscn")
		
	else:
		hp += value
		
	hit_points_bar.value = hp
	hit_points_bar2.value = hp
	update()

func _draw():
	draw_line(Vector2(60,40), Vector2(60 + hp ,40), Color.red, 3)
	
	draw_line(Vector2(60,60), Vector2(980,60), Color.white, 3)
	draw_line(Vector2(60,60), Vector2(60,560), Color.white, 3)
	draw_line(Vector2(60,560), Vector2(980,560), Color.white, 3)
	draw_line(Vector2(980,60), Vector2(980,560), Color.white, 3)
