extends Node

@onready var strings = $"../MarginContainer/VBoxContainer/BassFretboard/BoardPanel/Strings"

# The notes that can be asked in Level 1.
# This array will be modified as questions are answered.
var quiz = ["E", "A", "D", "G"]

# The note the game is asking the player to identify.
var question: String = ""

# The note selected by the player.
var answer: String = ""

# The number of correct answers.
var points: int = 0

# The total number of questions answered.
var count: int = 0

# The original colour of the string before highlighting.
var original_string_color: Color

# Keeps track of the previously highlighted string.
var previous_question: String = ""


func _ready() -> void:
	# Listen for note button presses from the EventBus.
	EventBus.note_button_pressed.connect(_on_note_button_pressed)

	# Start the first question.
	start_question()


func start_question() -> void:
	# End the level if there are no questions left.
	if quiz.is_empty():
		end_level()
		return

	# Choose a random note from the remaining questions.
	question = quiz.pick_random()

	# Remember the string's original colour before highlighting it.
	var string_line = strings.get_node(question).get_node("StringLine")
	original_string_color = string_line.color

	# Highlight the correct string.
	string_line.color = Color("#56DDF0")


func _on_note_button_pressed(note_name: String) -> void:
	# Ignore button presses after all questions have been answered.
	if question.is_empty():
		return

	# Store the note selected by the player.
	answer = note_name

	# Check whether the selected note is correct.
	check_answer()


func check_answer() -> void:
	# Award a point if the player's answer matches the question.
	if answer == question:
		points += 1

	# Count the question regardless of whether the answer was correct.
	count += 1

	# Remove this note so it cannot be asked again.
	quiz.erase(question)

	# Restore the previously highlighted string's original colour.
	var string_line = strings.get_node(question).get_node("StringLine")
	string_line.color = original_string_color

	# Clear the current question so additional button presses
	# cannot answer it more than once.
	question = ""

	# Move on to the next question or finish the level.
	next_question()


func next_question() -> void:
	# Continue if there are questions remaining.
	if not quiz.is_empty():
		start_question()
	else:
		end_level()


func end_level() -> void:
	# An empty question prevents further answers from being counted.
	question = ""

	# Display the final score.
	print("You got %d/%d correct!" % [points, count])
