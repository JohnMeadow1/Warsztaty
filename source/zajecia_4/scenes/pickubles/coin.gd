extends Node2D

var value = 1

func _ready():
	$Sprite/Label.text = str( value )
	$Sprite.self_modulate = Color.from_hsv( float(value) / 50.0, 1, 1 )
	
