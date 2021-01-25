extends Node2D

var iterator = 100
var text = "iterator = "

onready var hit_points = $HP

func _ready():
	iterator += 1
#	print (text, iterator)
#	print ("iterator = " + str(iterator) )
	print ("iterator = " + str(iterator) )

	for i in 10:
		print(i)
		hit_points.text = "HP = " + str(i)

func _process(delta):
	
	iterator += 1
	if iterator % 13 == 0:
		hit_points.text = "HP = " + str(iterator)
