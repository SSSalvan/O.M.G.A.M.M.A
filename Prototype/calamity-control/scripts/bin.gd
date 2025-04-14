extends Area2D

@export var accepted_type: String

func _on_area_entered(area):
	if area is RecycleItem and area.item_type == accepted_type:
		print("Correct item!")
		area.queue_free()
	else:
		print("Wrong item!")
