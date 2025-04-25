extends Node

var requirement: Array[int] = []

func _init():
	requirement.resize(10)
	for i in range(10):
		requirement[i] = randi()
