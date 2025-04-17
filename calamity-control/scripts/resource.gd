extends Node

var resource: int = 1000

func add_money(amount: int) -> void:
	resource += amount
	print("Got money, Resource is now: ", resource)

func subtract_money(amount: int) -> void:
	if resource >= amount:
		resource -= amount
		print("Spent money, Resource is now: ", resource)
