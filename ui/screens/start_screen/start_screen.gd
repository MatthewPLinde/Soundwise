extends Control

@onready var start_button: Button = $CenterContainer/ButtonBox/StartButton
const LEVEL_SELECT_SCREEN = preload("uid://cjwe4btrajtbv")


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_SELECT_SCREEN)
