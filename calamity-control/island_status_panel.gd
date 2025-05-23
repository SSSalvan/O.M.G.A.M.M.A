extends CanvasLayer

@onready var status_label = $BG_Island_Status/Status_Report_Title/ScrollContainer/Status_Report

func populate(island_data: Dictionary):
	var text = ""
	for island_name in island_data.keys():
		var data = island_data[island_name]
		text += "%s\n  ➤ Dev: %d | Emission: %d | Population: %d\n\n" % [
			island_name, data["development"], data["emission"], data["population"]
		] 
	status_label.text = text
	show()

func _on_close_button_pressed() -> void:
	queue_free()
