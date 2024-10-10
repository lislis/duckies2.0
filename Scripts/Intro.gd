extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_midi_button_down():
	if get_tree().change_scene_to_file("res://Scenes/GameMidi.tscn") != OK:
		print ("Error changing scene to GameMidi")


func _on_button_beat_button_down():
	if get_tree().change_scene_to_file("res://Scenes/GameConductor.tscn") != OK:
			print ("Error changing scene to GameConductor")
