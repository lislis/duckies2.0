extends Node2D

@export var head_down: bool = false

var head_down_counter = 0.0
var max_head_down = 0.4

func _process(delta):
	if head_down:
		$AnimatedSprite2D.frame = 1
		head_down_counter += delta
	else:
		$AnimatedSprite2D.frame = 0
		head_down_counter = 0
	if head_down_counter >= max_head_down:
		head_down = false
