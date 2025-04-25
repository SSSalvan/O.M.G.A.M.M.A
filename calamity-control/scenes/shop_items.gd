extends Node
var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

var howManyItemsBro = 5
func _ready():
	itemName.resize(howManyItemsBro)  # now it's [0, 0, 0, 0, 0]
	itemCount.resize(howManyItemsBro)
	itemPrice.resize(howManyItemsBro)
	
	itemName[0]  = "Panel Surya" #debug
	itemPrice[0] = 300
	
	itemName[1]  = "Turbin Angin" #debug
	itemPrice[1] = 450
	
	print("Item names array content: ", itemName)

func startGame():
	for i in range (howManyItemsBro):
		itemCount[i] = 0
