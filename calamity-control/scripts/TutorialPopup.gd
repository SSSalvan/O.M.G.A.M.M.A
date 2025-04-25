extends CanvasLayer

@onready var panel = $Panel
@onready var button = $Panel/Button

func _ready() -> void:
	visible = true
	get_tree().paused = true  # Pause the game while tutorial is shown
	button.pressed.connect(_on_button_pressed)
	panel.modulate.a = 0.9  # Make the panel slightly transparent

func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false
