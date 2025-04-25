extends Node2D
class_name DevelopProvince

signal confirmed

@export var game_manager: Node = null
@onready var title = $Action_Select/Popup/Title

var required_items: Dictionary = {}

func set_title_text(text: String):
	if title:
		title.text = text

func set_required_items(items: Dictionary):
	required_items = items
	var requirement_text = "\nRequires:\n"
	for index in items.keys():
		requirement_text += "- %s x%d\n" % [ShopItems.itemName[index], items[index]]
	title.text += requirement_text

func _on_yes_pressed():
	var can_develop = true
	for index in required_items.keys():
		if ShopItems.itemCount[index] < required_items[index]:
			can_develop = false
			break

	if can_develop:
		# Emit the confirmed signal without modifying the inventory here
		confirmed.emit()
	else:
		print("Not enough required items!")
	queue_free()

func _on_no_pressed():
	queue_free()
