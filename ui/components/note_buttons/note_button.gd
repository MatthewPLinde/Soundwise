extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_note_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _note_button_pressed():
	var note_name : String = get_text()
	EventBus.note_button_pressed.emit(note_name)
