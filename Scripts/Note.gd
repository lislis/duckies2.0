extends Area2D

@export var key = "s"

var speed = 0
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Key.text = key
	speed = Global.DIST_TO_TARGET / 2.0

func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 0:
			queue_free()
	else:
		$Node2D.position.y -= speed * delta

func destroy(score):
	$CPUParticles2D.emitting = true
	$Sprite2D.visible = false
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
