extends CanvasLayer

var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

func _ready():
	itemName.resize(5)  # now it's [0, 0, 0, 0, 0]
	itemCount.resize(5)
	itemPrice.resize(5)
	
	itemName[1]  = "Panel Surya" #debug
	itemPrice[1] = 300
	
	itemName[2]  = "Turbin Angin" #debug
	itemPrice[2] = 450
	
	print("Item names array content: ", itemName)
	#print(itemName[1])
	#print(itemName[2])

func _on_buy_panel_pressed() -> void:
	if ResourceCount.resource >= itemPrice[1]:
		itemCount[1]+=1
		ResourceCount.subtract_money(itemPrice[1])
		print("Bought, now ", itemCount[1], " Panel Surya")

func _on_buy_turbin_pressed() -> void:
	if ResourceCount.resource >= itemPrice[2]:
		itemCount[2]+=1
		ResourceCount.subtract_money(itemPrice[2])
		print("Bought, now ", itemCount[2], " Turbin Angin")
