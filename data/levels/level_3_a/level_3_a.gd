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
	EventBus.final_score = points
	EventBus.total_questions = count
	EventBus.current_level_score.emit(points, count)


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
