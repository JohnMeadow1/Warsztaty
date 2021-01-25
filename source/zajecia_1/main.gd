extends Node2D

var iterator = 100
var text = "iterator = "

onready var hit_points = $HP

func _ready():
#	print (text, iterator)
#	print ("iterator = " + str(iterator) )

#	iterator = iterator + 1
#	print ("iterator = " + str(iterator) )
	
	iterator += 1
	print ("iterator = " + str(iterator) )

	hit_points.text = "HP = " + str(iterator)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
