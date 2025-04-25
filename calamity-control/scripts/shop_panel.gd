extends CanvasLayer


@onready var item1Label: Label = $BG_ShopPanel/PanelSurya/QuantityPanel
@onready var item2Label: Label = $BG_ShopPanel/TurbinAngin/QuantityTurbin

func _ready():
	pass
	

	#print(itemName[1])
	#print(itemName[2])

func _on_buy_panel_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[0]:
		ShopItems.itemCount[0]+=1
		ResourceCount.subtract_money(ShopItems.itemPrice[0])
		print("Bought, now ", ShopItems.itemCount[0], " Panel Surya")
		item1Label.text = "%d" % ShopItems.itemCount[0]

func _on_buy_turbin_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[1]:
		ShopItems.itemCount[1]+=1
		ResourceCount.subtract_money(ShopItems.itemPrice[1])
		print("Bought, now ", ShopItems.itemCount[1], " Turbin Angin")
		item2Label.text = "%d" % ShopItems.itemCount[1]
