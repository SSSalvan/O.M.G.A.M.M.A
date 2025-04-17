extends CanvasLayer

var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

func _ready():
	itemCount.resize(5)  # now it's [0, 0, 0, 0, 0]
	
	itemName.append("Panel Surya") #debug
	itemPrice.append(300)
	
	itemName.append("Turbin Angin") #debug, runs at main menu??
	itemPrice.append(450)
	
	print("Item names array content: ", itemName)
	#print(itemName[1])
	#print(itemName[2])

func _on_buy_panel_pressed() -> void:
	itemCount[1]+=1
	if ResourceCount.resource >= itemPrice[1]:
		ResourceCount.subtract_money(itemPrice[1])
		print("Bought, now ", itemCount[1], " Panel Surya")

func _on_buy_turbin_pressed() -> void:
	itemCount[2]+=1
	if ResourceCount.resource >= itemPrice[2]:
		ResourceCount.subtract_money(itemPrice[2])
		print("Bought, now ", itemCount[2], " Turbin Angin")
