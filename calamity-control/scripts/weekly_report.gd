extends CanvasLayer

signal report_closed

@onready var report_text = $BG_weekly_report/ScrollContainer/island_report
@onready var title_label = $BG_weekly_report/title
@onready var confirm_button = $BG_weekly_report/confirm_button

func _ready():
	confirm_button.pressed.connect(_on_confirm_pressed)

func set_report(week: int, islands_data: Dictionary, required_dev: int):
	title_label.text = "End of Week {0} Report".format([week])
	var report = ""

	for island in islands_data.keys():
		var dev = islands_data[island]["development"]
		var emission = islands_data[island]["emission"]
		var population = islands_data[island]["population"]
		report += "{0}\n  ➤ Dev: {1} | Emission: {2} | Population: {3}\n".format([island, dev, emission, population])
	if week <= 2:
		report += "\n No minimum Dev needed for next week"
	else:
		report += "\n Minimum Dev for Week {0}: {1} ".format([week + 1, required_dev])
	report_text.text = report
	print(islands_data)

func _on_confirm_pressed():
	emit_signal("report_closed")
	queue_free()
