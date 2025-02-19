extends Node

@onready var week_counter: Label = $"Week Counter"

var week: int = 1

func ready():
	update_week_label()

func next_week():
	week += 1
	update_week_label()

func update_week_label():
	if week_counter:
		week_counter.text = "Week: " + str (week)
	print("Week Updated")
