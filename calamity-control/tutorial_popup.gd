extends CanvasLayer

@onready var panel = $Panel
@onready var button = $Panel/Button

func _ready() -> void:
	# Initially show the panel
	$Panel.visible = true

	# Ensure the button connects to the function
	button.pressed.connect(_on_button_pressed)

	# Make the panel slightly transparent (optional)
	panel.modulate = Color(1, 1, 1, 0.85)  # R, G, B, A (alpha for transparency)

func _on_button_pressed() -> void:
	# Hide the panel when the button is pressed
	$Panel.visible = false
