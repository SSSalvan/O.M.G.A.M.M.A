extends Control

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ShopPanel.ShowShopPanel(null, null)
	else:
		ShopPanel.HideShopPanel
