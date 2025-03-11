extends Node2D
class_name DevelopProvince 

signal confirmed

@onready var title = $Action_Select/Popup/Title

func _ready():
	title = get_node("Action_Select/Popup/Title")
	print("Title node: ", title)
	title.text = "yes king"

func set_title_text(text: String):
	if title:
		title.text = text
		title.queue_redraw()
	else:
		print("Title node not found!")

func _on_yes_pressed() -> void:
	confirmed.emit()
	queue_free()

func _on_no_pressed() -> void:
	queue_free()
