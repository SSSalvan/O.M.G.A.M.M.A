extends Node2D

@onready var week_counter: Label = $"Week Counter"  # Adjust if needed

var week: int = 1

func _ready():
	print("Week Counter: ", week_counter)  # Debugging
	if not week_counter:
		week_counter = get_node("Week Counter")  # Fallback
	update_week_label()

func _on_end_week_pressed() -> void:
	print("Button Pressed!")  # Debugging
	week += 1
	print("Week + 1, Week: ", week)
	if week_counter:
		week_counter.text = "Week: " + str(week)  # Avoids crashing
	else:
		print("not work :(((")

func update_week_label():
	print("Week Updated")
