extends Node
var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

func _ready():
	itemName.resize(5)  # now it's [0, 0, 0, 0, 0]
	itemCount.resize(5)
	itemPrice.resize(5)
	
	itemName[0]  = "Panel Surya" #debug
	itemPrice[0] = 300
	
	itemName[1]  = "Turbin Angin" #debug
	itemPrice[1] = 450
	
	print("Item names array content: ", itemName)
