extends Node

signal note_button_pressed(note_name: String)
signal current_level_selected(current_level: int)
signal current_level_score(level_score: int, total_questions: int)

var current_level: int = 1
var final_score: int = 0
var total_questions: int = 0
