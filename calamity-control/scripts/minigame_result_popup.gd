extends CanvasLayer

signal result_closed()

func set_result_text(title: String, description: String):
	$Result_Title.text = title
	$Result_Description.text = description

func _on_OK_Button_pressed():
	result_closed.emit()
	queue_free()


func _on_ok_button_pressed() -> void:
	pass # Replace with function body.
