extends Node2D

# keeping track of overall time
var delta_sum = 0.0
# time between the midiQueue and midiplay+music
var time_to_start = 1.0

var left = []

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
					print("hit")
				else:
					print("too early")
			else:
				print("This should not happen")
		if not elem.queue.is_empty():
			if elem.queue.front().test_miss(delta_sum):
				elem.queue.pop_front().miss()
				print("miss")
	

	if delta_sum >= time_to_start and not $music.playing:
		#$music.play()
		$midiPlay.play()
		$music.play()
		
	if delta_sum >= 3.0 and not $music.playing:
		pass
		

func _on_midi_queue_midi_event(channel, event):
	if channel.number == 2:
		var elem = state.get(event.note)
		
		# 128 on, 144 off
		if elem and event.type == 144:
			var n = note.instantiate()
			n.expected_time	= delta_sum + time_to_start
			n.global_position.y = -40 # is this calc or guess?
			n.global_position.x = elem.node.global_position.x
			n.color 				= elem.color
			n.key 				= elem.key
			add_child(n)
			elem.queue.push_back(n)
