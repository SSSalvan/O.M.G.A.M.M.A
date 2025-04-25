extends Node

var itemName: Array[String] = []
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

var howManyItemsBro = 12

func _ready():
	# Resize arrays
	itemName.resize(howManyItemsBro)
	itemCount.resize(howManyItemsBro)
	itemPrice.resize(howManyItemsBro)

	# Initialize item names and prices
	itemName[0] = "Solar Panel"
	itemPrice[0] = 300

	itemName[1] = "Wind Turbine"
	itemPrice[1] = 450

	itemName[2] = "Climate Education Program"
	itemPrice[2] = 400

	itemName[3] = "Rainforest Restoration"
	itemPrice[3] = 600

	itemName[4] = "Waste-to-Energy Plant"
	itemPrice[4] = 400

	itemName[5] = "Electric Vehicle Subsidy"
	itemPrice[5] = 300

	itemName[6] = "Green Building"
	itemPrice[6] = 200

	itemName[7] = "Blue Carbon Conservation"
	itemPrice[7] = 350

	itemName[8] = "Ocean Clean-up Drone"
	itemPrice[8] = 400

	itemName[9] = "Carbon Storage Dome"
	itemPrice[9] = 500

	itemName[10] = "Soil Restoration Kit"
	itemPrice[10] = 450

	itemName[11] = "Anti-Erosion Barrier"
	itemPrice[11] = 150

	# Reset inventory counts
	start_game()

func start_game():
	# Reset all item counts to zero at the start of the game
	for i in range(howManyItemsBro):
		itemCount[i] = 0

func add_item(item_index: int, quantity: int):
	if item_index >= 0 and item_index < howManyItemsBro:
		itemCount[item_index] += quantity
		print("Added ", quantity, " of item ", itemName[item_index])

func remove_item(item_index: int, quantity: int) -> bool:
	if item_index >= 0 and item_index < howManyItemsBro:
		if itemCount[item_index] >= quantity:
			itemCount[item_index] -= quantity
			print("Removed ", quantity, " of item ", itemName[item_index])
			return true
		else:
			print("Not enough of item ", itemName[item_index], " in inventory")
			return false
	return false

func get_item_count(item_index: int) -> int:
	if item_index >= 0 and item_index < howManyItemsBro:
		return itemCount[item_index]
	return 0

func get_item_name(item_index: int) -> String:
	if item_index >= 0 and item_index < howManyItemsBro:
		return itemName[item_index]
	return ""

func get_item_price(item_index: int) -> int:
	if item_index >= 0 and item_index < howManyItemsBro:
		return itemPrice[item_index]
	return 0
