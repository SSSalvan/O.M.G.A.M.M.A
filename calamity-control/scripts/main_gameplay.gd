extends Node2D

@onready var week_counter: Label = $"GameManager/Week Counter"
var week: int = 1

func _ready():
	call_deferred("_print_tree")
	_show_tutorial_popup()

func _print_tree():
	# get_tree().root.print_tree_pretty()
	pass

func _show_tutorial_popup():
	var popup_scene = preload("res://scenes/TutorialPopup.tscn")
	var popup_instance = popup_scene.instantiate()
	add_child(popup_instance)
