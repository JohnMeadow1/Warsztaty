extends Node2D

var hp = 100
export(int) var max_hp = 500
var text = "iterator = "

onready var hit_points_label = $HP

func _ready():
	hp += 1
#	print (text, iterator)
#	print ("iterator = " + str(iterator) )
	print ("iterator = " + str(hp) )

	for i in 10:
		print(i)
		hit_points_label.text = "HP = " + str(i)

func _process(delta):
	if hp < max_hp:
		hp += 1
		
	if hp % 10 == 0:
		hit_points_label.text = "HP = " + str(hp)
