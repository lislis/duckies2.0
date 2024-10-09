extends Node

const TARGET_X = 100
const SPAWN_X = 1280
const DIST_TO_TARGET = abs(TARGET_X - SPAWN_X)

var score = 0
var combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"

func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene_to_file("res://Scenes/Intro.tscn") != OK:
			print ("Error changing scene to GameMidi")
