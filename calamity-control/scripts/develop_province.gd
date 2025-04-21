extends Node2D
class_name DevelopProvince

signal confirmed

@export var game_manager: Node = null
@onready var title = $Action_Select/Popup/Title

func set_title_text(text: String):
	if title:
		title.text = text

func _on_yes_pressed():
	print("GameManager in popup: ", game_manager)
	if game_manager and ResourceCount.resource >= 400:
		confirmed.emit()
	else:
		print("Not enough resources!")
	queue_free()

func _on_no_pressed():
	queue_free()
