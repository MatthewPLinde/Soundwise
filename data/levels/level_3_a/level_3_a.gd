extends Node

@onready var frets = $"../MarginContainer/VBoxContainer/BassFretboard/BoardPanel/Strings/A/Frets"


var quiz = [
	{"fret": 0, "note": "A"},
	{"fret": 1, "note": "A#"},
	{"fret": 2, "note": "B"},
	{"fret": 3, "note": "C"},
	{"fret": 4, "note": "C#"},
	{"fret": 5, "note": "D"},
	{"fret": 6, "note": "D#"},
	{"fret": 7, "note": "E"},
	{"fret": 8, "note": "F"},
	{"fret": 9, "note": "F#"},
	{"fret": 10, "note": "G"},
	{"fret": 11, "note": "G#"},
	{"fret": 12, "note": "A"},
	{"fret": 13, "note": "A#"},
	{"fret": 14, "note": "B"},
	{"fret": 15, "note": "C"},
	{"fret": 16, "note": "C#"},
	{"fret": 17, "note": "D"},
	{"fret": 18, "note": "D#"},
	{"fret": 19, "note": "E"},
	{"fret": 20, "note": "F"}
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
