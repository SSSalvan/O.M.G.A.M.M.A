extends Node

@onready var week_counter: Label = $"Week Counter"

var week: int = 1

func _on_end_week_pressed() -> void:
	next_week()

func _ready():
	update_week_label()

func next_week():
	week += 1
	update_week_label()

func update_week_label():
	week_counter.text = "Week: " + str (week)
	print("Week Updated, Bisma Gemoy, Week: ", week)
