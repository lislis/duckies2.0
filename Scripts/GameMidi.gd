extends Node2D

# keeping track of overall time
var delta_sum = 0.0
# time between the midiQueue and midiplay+music
var time_to_start = 1.0

var note = preload("res://Scenes/MidiNote.tscn")

@onready var state = {
	60: {
		"color": Color.MEDIUM_PURPLE,
		"key": "s",
		"queue": [],
		"node": get_node("buttons/btnS")
	},
	62: {
		"color": Color.PURPLE,
		"key": "d",
		"queue": [],
		"node": get_node("buttons/btnD")
	},
	64: {
		"color": Color.WEB_PURPLE,
		"key": "f",
		"queue": [],
		"node": get_node("buttons/btnF")
	},
	65: {
		"color": Color.REBECCA_PURPLE,
		"key": "j",
		"queue": [],
		"node": get_node("buttons/btnJ")
	},
	67: {
		"color": Color.DEEP_PINK,
		"key": "k",
		"queue": [],
		"node": get_node("buttons/btnK")
	},
	69: {
		"color": Color.HOT_PINK,
		"key": "l",
		"queue": [],
		"node": get_node("buttons/btnL")
	}
}

func _ready():
	for s in state.values():
		s.node.color = s.color

func _process(delta):
	delta_sum += delta
	
	for elem in state.values():
		if Input.is_action_just_pressed(elem.key):
			if not elem.queue.is_empty():
				print(elem.queue.front().expected_time, " ",  delta_sum)
				if elem.queue.front().test_hit(delta_sum):
					elem.queue.pop_front().hit()
					$Duckie.head_down = true
					elem.node.get_node("Message").text = "Great"
					print("hit")
				else:
					elem.node.get_node("Message").text = "Too early"
					print("too early")
			else:
				print("Nothing here yet")
		if not elem.queue.is_empty():
			if elem.queue.front().test_miss(delta_sum):
				elem.queue.pop_front().miss()
				elem.node.get_node("Message").text = "Miss"
				print("miss")

	if delta_sum >= time_to_start and not $music.playing:
		#$music.play()
		$midiPlay.play()
		$music.play()
		
	if delta_sum >= 3.0 and not $music.playing:
		pass
		

func _on_midi_queue_midi_event(channel, event):
	if channel.number == 2:
		queue_midi_note(event)
	if channel.number == 3:
		animate_duckie(event)


func queue_midi_note(ev):
	var elem = state.get(ev.note)
		# 128 on, 144 off
	if elem and ev.type == 144:
		var n = note.instantiate()
		n.expected_time	= delta_sum + time_to_start
		n.global_position.y = -40 # is this calc or guess?
		n.global_position.x = elem.node.global_position.x
		n.color 				= elem.color
		n.key 				= elem.key
		add_child(n)
		elem.queue.push_back(n)

func animate_duckie(ev):
	if ev.type == 128:
		var tween = create_tween()
		tween.tween_property($Duckie, "position:y", 372, 0.4)
	elif ev.type == 144:
		var tween = create_tween()
		tween.tween_property($Duckie, "position:y", 392, 0.4)
