extends Node

@onready var strings = $"../MarginContainer/VBoxContainer/BassFretboard/BoardPanel/Strings"

var quiz = [
	# E string
	{"string": "E", "fret": 0, "note": "E"},
	{"string": "E", "fret": 1, "note": "F"},
	{"string": "E", "fret": 2, "note": "F#"},
	{"string": "E", "fret": 3, "note": "G"},
	{"string": "E", "fret": 4, "note": "G#"},
	{"string": "E", "fret": 5, "note": "A"},
	{"string": "E", "fret": 6, "note": "A#"},
	{"string": "E", "fret": 7, "note": "B"},
	{"string": "E", "fret": 8, "note": "C"},
	{"string": "E", "fret": 9, "note": "C#"},
	{"string": "E", "fret": 10, "note": "D"},
	{"string": "E", "fret": 11, "note": "D#"},
	{"string": "E", "fret": 12, "note": "E"},
	{"string": "E", "fret": 13, "note": "F"},
	{"string": "E", "fret": 14, "note": "F#"},
	{"string": "E", "fret": 15, "note": "G"},
	{"string": "E", "fret": 16, "note": "G#"},
	{"string": "E", "fret": 17, "note": "A"},
	{"string": "E", "fret": 18, "note": "A#"},
	{"string": "E", "fret": 19, "note": "B"},
	{"string": "E", "fret": 20, "note": "C"},

	# A string
	{"string": "A", "fret": 0, "note": "A"},
	{"string": "A", "fret": 1, "note": "A#"},
	{"string": "A", "fret": 2, "note": "B"},
	{"string": "A", "fret": 3, "note": "C"},
	{"string": "A", "fret": 4, "note": "C#"},
	{"string": "A", "fret": 5, "note": "D"},
	{"string": "A", "fret": 6, "note": "D#"},
	{"string": "A", "fret": 7, "note": "E"},
	{"string": "A", "fret": 8, "note": "F"},
	{"string": "A", "fret": 9, "note": "F#"},
	{"string": "A", "fret": 10, "note": "G"},
	{"string": "A", "fret": 11, "note": "G#"},
	{"string": "A", "fret": 12, "note": "A"},
	{"string": "A", "fret": 13, "note": "A#"},
	{"string": "A", "fret": 14, "note": "B"},
	{"string": "A", "fret": 15, "note": "C"},
	{"string": "A", "fret": 16, "note": "C#"},
	{"string": "A", "fret": 17, "note": "D"},
	{"string": "A", "fret": 18, "note": "D#"},
	{"string": "A", "fret": 19, "note": "E"},
	{"string": "A", "fret": 20, "note": "F"},

	# D string
	{"string": "D", "fret": 0, "note": "D"},
	{"string": "D", "fret": 1, "note": "D#"},
	{"string": "D", "fret": 2, "note": "E"},
	{"string": "D", "fret": 3, "note": "F"},
	{"string": "D", "fret": 4, "note": "F#"},
	{"string": "D", "fret": 5, "note": "G"},
	{"string": "D", "fret": 6, "note": "G#"},
	{"string": "D", "fret": 7, "note": "A"},
	{"string": "D", "fret": 8, "note": "A#"},
	{"string": "D", "fret": 9, "note": "B"},
	{"string": "D", "fret": 10, "note": "C"},
	{"string": "D", "fret": 11, "note": "C#"},
	{"string": "D", "fret": 12, "note": "D"},
	{"string": "D", "fret": 13, "note": "D#"},
	{"string": "D", "fret": 14, "note": "E"},
	{"string": "D", "fret": 15, "note": "F"},
	{"string": "D", "fret": 16, "note": "F#"},
	{"string": "D", "fret": 17, "note": "G"},
	{"string": "D", "fret": 18, "note": "G#"},
	{"string": "D", "fret": 19, "note": "A"},
	{"string": "D", "fret": 20, "note": "A#"},

	# G string
	{"string": "G", "fret": 0, "note": "G"},
	{"string": "G", "fret": 1, "note": "G#"},
	{"string": "G", "fret": 2, "note": "A"},
	{"string": "G", "fret": 3, "note": "A#"},
	{"string": "G", "fret": 4, "note": "B"},
	{"string": "G", "fret": 5, "note": "C"},
	{"string": "G", "fret": 6, "note": "C#"},
	{"string": "G", "fret": 7, "note": "D"},
	{"string": "G", "fret": 8, "note": "D#"},
	{"string": "G", "fret": 9, "note": "E"},
	{"string": "G", "fret": 10, "note": "F"},
	{"string": "G", "fret": 11, "note": "F#"},
	{"string": "G", "fret": 12, "note": "G"},
	{"string": "G", "fret": 13, "note": "G#"},
	{"string": "G", "fret": 14, "note": "A"},
	{"string": "G", "fret": 15, "note": "A#"},
	{"string": "G", "fret": 16, "note": "B"},
	{"string": "G", "fret": 17, "note": "C"},
	{"string": "G", "fret": 18, "note": "C#"},
	{"string": "G", "fret": 19, "note": "D"},
	{"string": "G", "fret": 20, "note": "D#"}
]

var question: Dictionary = {}
var answer: String = ""
var points: int = 0
var count: int = 0
var original_string_color: Color


func _ready() -> void:
	EventBus.note_button_pressed.connect(_on_note_button_pressed)
	start_question()


func start_question() -> void:
	if quiz.is_empty():
		end_level()
		return
	
	question = quiz.pick_random()
	
	var fret_line = get_active_fret_line()
	original_string_color = fret_line.color
	fret_line.color = Color("#56DDF0")


func _on_note_button_pressed(note_name: String) -> void:
	if question.is_empty():
		return
	
	answer = note_name
	check_answer()


func check_answer() -> void:
	# Only 1 answer to check: compare clicked note to the target note
	if answer == question["note"]:
		points += 1
	
	count += 1
	
	# Unhighlight the fret line
	var fret_line = get_active_fret_line()
	fret_line.color = original_string_color
	
	quiz.erase(question)
	question = {}
	
	next_question()


func next_question() -> void:
	if not quiz.is_empty():
		start_question()
	else:
		end_level()


func end_level() -> void:
	question = {}
	print("You got %d/%d correct!" % [points, count])


# Helper function to find the exact FretLine node on any string
func get_active_fret_line() -> Node:
	var path: String = "%s/Frets/%d/FretLine" % [question["string"], question["fret"]]
	return strings.get_node(path)
