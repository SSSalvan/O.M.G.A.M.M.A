extends Control

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		EmissionRateStatusPopup.StatusPopup(Rect2i(), null)
	else:
		EmissionRateStatusPopup.HideStatusPopup()
