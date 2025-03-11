extends Control
class_name DevelopProvince 

signal confirmed


func _on_yes_pressed() -> void:
	print("Yes button pressed")
	confirmed.emit()
	queue_free()

func _on_no_pressed() -> void:
	print("No button pressed!")
	queue_free()
