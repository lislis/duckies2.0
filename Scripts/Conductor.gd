extends AudioStreamPlayer2D

@export var bpm := 100
@export var measures := 4
@export var midi_file := ""

# Tracking the beat and song position
var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0

signal b_beat(position)
signal b_measure(position)
signal b_midi(channel, event)

func _ready():
	sec_per_beat = 60.0 / bpm
	$MidiPlayer.set_file(midi_file)

func _physics_process(_delta):
	#sec_per_beat = Engine.get_frames_per_second() / bpm
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		_report_beat()


func _report_beat():
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		emit_signal("b_beat", song_position_in_beats)
		emit_signal("b_measure", measure)
		last_reported_beat = song_position_in_beats
		measure += 1


func play_with_beat_offset(num):
	beats_before_start = num
	#var sec_before_start = sec_per_beat * beats_before_start
	#$MidiStartTimer.wait_time = sec_per_beat
	#$MidiStartTimer.start()
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()

func _on_StartTimer_timeout():
	#print("start timout")
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		$StartTimer.start()
	elif song_position_in_beats == beats_before_start - 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() +
														AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		$MidiPlayer.play()
		$StartTimer.stop()
	_report_beat()

func _on_midi_player_midi_event(channel, event):
	emit_signal("b_midi", channel, event)
