extends Node2D

@onready var week_counter: Label = $"Week Counter"  # Adjust if needed

var week: int = 1

func _ready():
	call_deferred("_print_tree")

func _print_tree():
	print("Scene tree structure:")
	get_tree().root.print_tree_pretty()


func _on_shop_pressed() -> void:
	pass # Replace with function body.
