extends Node

var requirement: Array[int] = []

func _init():
	requirement.resize(11)
	for i in range(11):
		requirement[i] = randi_range(0, 11)
