extends Node

@onready var frets = $"../MarginContainer/VBoxContainer/BassFretboard/BoardPanel/Strings/G/Frets"


var quiz = [
	{"fret": 0, "note": "G"},
	{"fret": 1, "note": "G#"},
	{"fret": 2, "note": "A"},
	{"fret": 3, "note": "A#"},
	{"fret": 4, "note": "B"},
	{"fret": 5, "note": "C"},
	{"fret": 6, "note": "C#"},
	{"fret": 7, "note": "D"},
	{"fret": 8, "note": "D#"},
	{"fret": 9, "note": "E"},
	{"fret": 10, "note": "F"},
	{"fret": 11, "note": "F#"},
	{"fret": 12, "note": "G"},
	{"fret": 13, "note": "G#"},
	{"fret": 14, "note": "A"},
	{"fret": 15, "note": "A#"},
	{"fret": 16, "note": "B"},
	{"fret": 17, "note": "C"},
	{"fret": 18, "note": "C#"},
	{"fret": 19, "note": "D"},
	{"fret": 20, "note": "D#"}
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
	
	var fret_number_text: String = str(question["fret"])
	var fret_line = frets.get_node(fret_number_text).get_node("FretLine")
	
	original_string_color = fret_line.color
	fret_line.color = Color("#56DDF0")


func _on_note_button_pressed(note_name: String) -> void:
	if question.is_empty():
		return
	
	answer = note_name
	check_answer()


func check_answer() -> void:
	if answer == question["note"]:
		points += 1
	
	count += 1
	
	var fret_number_text: String = str(question["fret"])
	var fret_line = frets.get_node(fret_number_text).get_node("FretLine")
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
