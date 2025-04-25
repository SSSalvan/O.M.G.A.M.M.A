extends Node
var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

var howManyItemsBro = 53
func _ready():
	itemName.resize(howManyItemsBro)  # now it's [0, 0, 0, 0, 0]
	itemCount.resize(howManyItemsBro)
	itemPrice.resize(howManyItemsBro)
	
	itemName[0]  = "Solar Panel"
	itemPrice[0] = 300
	
	itemName[1]  = "Wind Turbine"
	itemPrice[1] = 450

	itemName[2]  = "Climate Education Program"
	itemPrice[2] = 0

	itemName[3]  = "Rainforest Restoration"
	itemPrice[3] = 0

	itemName[4]  = "Waste-to-Energy Plant"
	itemPrice[4] = 0

	itemName[5]  = "Electric Vehicle Subsidy"
	itemPrice[5] = 0

	itemName[6]  = "Green Building"
	itemPrice[6] = 0

	itemName[7]  = "Blue Carbon Conservation"
	itemPrice[7] = 0

	itemName[8] = "Ocean Clean-up Drone"
	itemPrice[8]= 0

	itemName[9] = "Carbon Storage Dome"
	itemPrice[9]= 0

	itemName[10] = "Soil Restoration Kit"
	itemPrice[10]= 0

	itemName[11] = "Anti-Erosion Barrier"
	itemPrice[11]= 0

	print("Item names array content: ", itemName)

func startGame():
	for i in range (howManyItemsBro):
		itemCount[i] = 0
