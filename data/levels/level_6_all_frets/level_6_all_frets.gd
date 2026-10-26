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
	if fret_line == null:
		print("Error: Could not find fret node for string %s, fret %d" % [question["string"], question["fret"]])
		return
		
	original_string_color = fret_line.color
	fret_line.color = Color("#56DDF0")


func _on_note_button_pressed(button: Button, note_name: String) -> void:
	if question.is_empty():
		return
	
	answer = note_name.strip_edges()
	var is_correct: bool = (answer == question["note"])

	# Trigger green/red flash without blocking user input
	show_button_feedback(button, is_correct)

	# Pass is_correct into check_answer
	check_answer(is_correct)


func check_answer(is_correct: bool) -> void:
	if is_correct:
		points += 1
	
	count += 1
	
	var fret_line = get_active_fret_line()
	if fret_line != null:
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
	EventBus.final_score = points
	EventBus.total_questions = count
	EventBus.current_level_score.emit(points, count)


func get_active_fret_line() -> Node:
	if question.is_empty():
		return null
	var path: String = "%s/Frets/%d/FretLine" % [question["string"], question["fret"]]
	return strings.get_node_or_null(path)


func show_button_feedback(button: Button, is_correct: bool) -> void:
	var feedback_style := StyleBoxFlat.new()
	
	feedback_style.corner_radius_top_left = 6
	feedback_style.corner_radius_top_right = 6
	feedback_style.corner_radius_bottom_right = 6
	feedback_style.corner_radius_bottom_left = 6
	feedback_style.set_border_width_all(2)
	feedback_style.content_margin_left = 16
	feedback_style.content_margin_top = 8
	feedback_style.content_margin_right = 16
	feedback_style.content_margin_bottom = 8

	if is_correct:
		feedback_style.bg_color = Color("#1E4620")
		feedback_style.border_color = Color("#4EFA8B")
	else:
		feedback_style.bg_color = Color("#581C1C")
		feedback_style.border_color = Color("#FF5252")

	# Override normal, hover, and pressed so feedback shows under mouse hover
	button.add_theme_stylebox_override("normal", feedback_style)
	button.add_theme_stylebox_override("hover", feedback_style)
	button.add_theme_stylebox_override("pressed", feedback_style)

	await get_tree().create_timer(1.0).timeout

	button.remove_theme_stylebox_override("normal")
	button.remove_theme_stylebox_override("hover")
	button.remove_theme_stylebox_override("pressed")
