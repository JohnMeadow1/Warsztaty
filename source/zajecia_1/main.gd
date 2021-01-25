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
		hp += 1
		
	hit_points_bar.value = hp
	hit_points_bar2.value = hp
		
#	if hp % 10 == 0:
#		hit_points_label.text = "HP = " + str(hp)
