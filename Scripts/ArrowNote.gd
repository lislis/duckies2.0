extends Area2D

const TARGET_X = 130
const SPAWN_X = 1080
const DIST_TO_TARGET = abs(TARGET_X - SPAWN_X)

const LEFT_LANE_SPAWN = Vector2(SPAWN_X, 208)
const CENTRE_LANE_SPAWN = Vector2(SPAWN_X, 46)
const RIGHT_LANE_SPAWN = Vector2(SPAWN_X, 125)

var speed = 0
var hit = false

func _ready():
	pass

func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 100:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.x += speed * delta


func initialize(lane):
	if lane == 0:
		$AnimatedSprite.frame = 0
		position = LEFT_LANE_SPAWN
	elif lane == 1:
		$AnimatedSprite.frame = 1
		position = CENTRE_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite.frame = 2
		position = RIGHT_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	speed = DIST_TO_TARGET / 2.0


func destroy(score):
	$CPUParticles.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "GREAT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")


func _on_Timer_timeout():
	queue_free()
