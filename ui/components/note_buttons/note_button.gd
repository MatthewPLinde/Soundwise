extends Button

@export var note_name: String = ""

func _ready() -> void:
	pressed.connect(_note_button_pressed)

func _note_button_pressed() -> void:
	# If note_name export is blank in the Inspector, fall back to button text
	var note_to_send: String = note_name if not note_name.is_empty() else text
	EventBus.note_button_pressed.emit(self, note_to_send.strip_edges())
