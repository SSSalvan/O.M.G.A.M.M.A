extends Control

signal confirmed
	
func _on_yes_pressed() -> void:
	print("Yes button pressed")
	confirmed.emit()
	get_parent().queue_free()

func _on_no_pressed() -> void:
	print("No button pressed!")
	get_parent().queue_free()
