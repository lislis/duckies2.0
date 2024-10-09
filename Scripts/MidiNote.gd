extends Sprite2D

@export var expected_time: float
@export var color: Color
@export var key: String

var state = ""
var error_margin: float = 0.2

func _ready():
	$Key.text = key

func _process(delta):
	if state == "hit":
		queue_free()
		return
	
	# node start position - position of button to match
	var speed = abs(-40.0 - 500.0) 
	#global_position.y += delta * 600.0 # calc or guess?
	global_position.y += delta * speed # calc or guess?
	
	if state == "miss":
		if global_position.y > 600.0: # window height?
			queue_free()

func test_hit(time: float):
	if abs(expected_time - time ) < error_margin:
		return true
	return false
	
func test_miss(time: float):
	if time > expected_time + error_margin:
		return true
	return false
	
func hit():
	state = "hit"
	$state.text = "hit"
	#global_position = position_to_freeze
	
func miss():
	state = "miss"
	$state.text = "miss"
	
	
