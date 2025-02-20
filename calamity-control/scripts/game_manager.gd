extends Node

@onready var week_counter: Label = $"Week Counter"

var week: int = 1

func _on_end_week_pressed() -> void:
	var confirm_scene = load("res://scenes/week_end_confirmation.tscn").instantiate()
	add_child(confirm_scene)
	
	var control_node = confirm_scene.get_node("Confirm_Week")
	
	if control_node and control_node.has_signal("confirmed"):
		print("Signal found!")  # Debugging
		control_node.confirmed.connect(self.next_week)
	else:
		print("ERROR: Signal 'confirmed' not found!")  # Debugging
	
	print("Button Pressed")

func _ready():
	update_week_label()

func next_week():
	week += 1
	update_week_label()

func update_week_label():
	week_counter.text = "Week: " + str (week)
	print("Week Updated, Bisma Gemoy, Week: ", week)
