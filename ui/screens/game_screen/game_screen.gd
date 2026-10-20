extends Control

@onready var keyboard_container: CenterContainer = $MarginContainer/VBoxContainer/KeyboardContainer
const BASS_ALL_KEYBOARD = preload("uid://cd700ef6bphf")
const BASS_OPEN_KEYBOARD = preload("uid://rrmmd783qttx")
const LEVEL_1_OPEN = preload("uid://bpx1gad45he8b")
const LEVEL_2_E = preload("uid://qklp7mphktfn")
const LEVEL_3_A = preload("uid://q6ivgal7xrki")
const LEVEL_4_D = preload("uid://c72q06b77n46s")
const LEVEL_5_G = preload("uid://c7lpeouovxvsh")

var current_level : int = 1

func _ready() -> void:
	EventBus.current_level_selected.emit(current_level)
	
	match current_level:
		1: level_1()
		2: level_2()
		3: level_3()
		4: level_4()
		5: level_5()

func level_1():
	clear_current_level()
	
	var keyboard = BASS_OPEN_KEYBOARD.instantiate()
	keyboard_container.add_child(keyboard)
	
	var level = LEVEL_1_OPEN.instantiate()
	add_child(level)

func level_2():
	clear_current_level()
	
	var keyboard = BASS_ALL_KEYBOARD.instantiate()
	keyboard_container.add_child(keyboard)
	
	var level = LEVEL_2_E.instantiate()
	add_child(level)

func level_3():
	clear_current_level()
	
	var keyboard = BASS_ALL_KEYBOARD.instantiate()
	keyboard_container.add_child(keyboard)
	
	var level = LEVEL_3_A.instantiate()
	add_child(level)

func level_4():
	clear_current_level()
	
	var keyboard = BASS_ALL_KEYBOARD.instantiate()
	keyboard_container.add_child(keyboard)
	
	var level = LEVEL_4_D.instantiate()
	add_child(level)

func level_5():
	clear_current_level()
	
	var keyboard = BASS_ALL_KEYBOARD.instantiate()
	keyboard_container.add_child(keyboard)
	
	var level = LEVEL_5_G.instantiate()
	add_child(level)

func clear_current_level():
	for level in get_tree().get_nodes_in_group("levels"):
		if level.get_parent() == self:
			level.queue_free()
	
	for keyboard in get_tree().get_nodes_in_group("keyboards"):
		if keyboard.get_parent() == keyboard_container:
			keyboard.queue_free()
