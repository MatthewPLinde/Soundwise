extends Control

@onready var score_label: Label = $CenterContainer/VBoxContainer/ScoreLabel

var can_dismiss: bool = false


func _ready() -> void:
	score_label.text = "Score: %d / %d" % [
		EventBus.final_score,
		EventBus.total_questions
	]
	
	await get_tree().create_timer(0.2).timeout
	can_dismiss = true


func _input(event: InputEvent) -> void:
	if not can_dismiss:
		return

	if event is InputEventKey and event.pressed and not event.is_echo():
		_open_level_select()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_open_level_select()
	elif event is InputEventScreenTouch and event.pressed:
		_open_level_select()


func _open_level_select() -> void:
	get_viewport().set_input_as_handled()
	get_tree().change_scene_to_file("uid://cjwe4btrajtbv")
