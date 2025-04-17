extends CanvasLayer

var itemName: Array[String] = [""]
var itemCount: Array[int] = []

func _ready():
	itemCount.resize(5)  # now it's [0, 0, 0, 0, 0]
	itemName.append("Panel Surya") #debug
	itemName.append("Turbin Angin") #debug, runs at main menu??
	print("Item names array content: ", itemName)
	print(itemName[1])
	print(itemName[2])

func _on_buy_panel_pressed() -> void:
	itemCount[1]+=1
	if ResourceCount.resource >= 300:
		ResourceCount.subtract_money(300)
		print("Bought, now ", itemCount[1], " Panel Surya")

func _on_buy_turbin_pressed() -> void:
	itemCount[2]+=1
	if ResourceCount.resource >= 450:
		ResourceCount.subtract_money(450)
		print("Bought, now ", itemCount[2], " Turbin Angin")
