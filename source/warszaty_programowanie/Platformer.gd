extends Node2D


var platform_object = load("res://Platform.tscn")

func _ready():
	
	for i in 20:
		var new_platform = platform_object.instance()
		new_platform.position = Vector2( i * 64, 400 )
		add_child(new_platform)
		
	for i in 5:
		var new_platform = platform_object.instance()
		new_platform.position = Vector2( 100 + i * 64, 150 + randi()%3 * 64 )
		add_child(new_platform)
