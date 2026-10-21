extends Control

@onready var level_1_button: Button = $CenterContainer/ContentBox/LevelGrid/Level1Button
@onready var level_2_button: Button = $CenterContainer/ContentBox/LevelGrid/Level2Button
@onready var level_3_button: Button = $CenterContainer/ContentBox/LevelGrid/Level3Button
@onready var level_4_button: Button = $CenterContainer/ContentBox/LevelGrid/Level4Button
@onready var level_5_button: Button = $CenterContainer/ContentBox/LevelGrid/Level5Button
@onready var level_6_button: Button = $CenterContainer/ContentBox/LevelGrid/Level6Button

const GAME_SCREEN = preload("uid://d2pfmc2ksoduw")


func _ready() -> void:
	level_1_button.pressed.connect(func(): _on_level_selected(1))
	level_2_button.pressed.connect(func(): _on_level_selected(2))
	level_3_button.pressed.connect(func(): _on_level_selected(3))
	level_4_button.pressed.connect(func(): _on_level_selected(4))
	level_5_button.pressed.connect(func(): _on_level_selected(5))
	level_6_button.pressed.connect(func(): _on_level_selected(6))


func _on_level_selected(level_number: int) -> void:
	EventBus.current_level = level_number
	EventBus.current_level_selected.emit(level_number)
	get_tree().change_scene_to_packed(GAME_SCREEN)
