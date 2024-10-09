extends Node2D

const TARGET_X = Global.TARGET_X
const SPAWN_X = Global.SPAWN_X
const DIST_TO_TARGET = abs(TARGET_X - SPAWN_X)

var speed = 0
#var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = DIST_TO_TARGET / 2.0

func _physics_process(delta):
	#if !hit:
	position.x -= speed * delta
	if position.x < 0:
		queue_free()
		#get_parent().reset_combo()
	#else:
		#$Node2D.position.x += speed * delta
	
