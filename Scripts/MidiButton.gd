extends Node2D

@export var pressed: bool
@export var color: Color
@export var key: String

func _input(event):
	if Input.is_action_just_pressed(key):
		pressed = true
	if Input.is_action_just_released(key):
		pressed = false

func _ready():
	$Key.text = key

func _process(delta):
	if pressed:
		modulate = lerp(modulate, color, 1.0)
		scale.y = lerp(scale.y, 0.95, 1.0)
		scale.x = lerp(scale.x, 0.95, 1.0)
	else:
		modulate = lerp(modulate, Color.LIGHT_SLATE_GRAY, delta * 10.0)
		scale.y = lerp(scale.y, 1.0, delta * 1.0)
		scale.x = lerp(scale.x, 1.0, delta * 1.0)
