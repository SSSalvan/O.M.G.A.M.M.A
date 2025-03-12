extends PanelContainer


func _on_mouse_entered() -> void:
	EmissionRateStatusPopup.StatusPopup(null, null)


func _on_mouse_exited() -> void:
	EmissionRateStatusPopup.HideStatusPopup()
