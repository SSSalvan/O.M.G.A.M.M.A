extends Button
@onready var shop_panel = $CanvasLayer/ShopPanel

func _on_ToggleShopButton_pressed():
	shop_panel.visible = !shop_panel.visible
