extends Node
const INT32_MAX = 2147483647
var resource: int = 1000

func add_money(amount: int) -> void:
	resource += amount
	if resource > INT32_MAX:
		resource = INT32_MAX
	print("Got money, Resource is now: ", resource)

func subtract_money(amount: int) -> void:
	if resource >= amount:
		resource -= amount
		print("Spent money, Resource is now: ", resource)
