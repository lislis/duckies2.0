extends Node2D

var once = true

var bar = preload("res://Scenes/Bar.tscn")
var note = preload("res://Scenes/Note.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$Conductor.play_with_beat_offset(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if once:
		#if Input.is_action_just_pressed("ui_up"):
			#$Conductor.play_with_beat_offset(2)
			##instantiate_bar()
			#once = false
			#$StartLabel.queue_free()
			

func _on_conductor_b_beat(position):
	#print(position)
	instantiate_bar()

func _on_conductor_b_midi(channel, event):
	#if channel.number == 3:
		##print(event.type)
		#if event.type == 144:
			#instantiate_bar()
	if channel.number == 2 && event.type == 128:
		print(event.note)
		#if event.type == 128:
			#instantiate_note()

func _on_conductor_b_measure(position):
	pass

func instantiate_note():
	var new_n = note.instantiate()
	new_n.set_position(Vector2(Global.SPAWN_X, 120))
	add_child(new_n)

func instantiate_bar():
	var new_b = bar.instantiate()
	new_b.set_position(Vector2(Global.SPAWN_X, 70))
	add_child(new_b)
