extends Control

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		var game_manager = get_tree().root.get_node("MainGameplay/GameManager")
		if game_manager:
			var island_name = "Sumatra"  # Replace with the actual island name for this slot
			var island_data = game_manager.islands[island_name]
			EmissionRateStatusPopup.update_status(
				island_name,
				island_data["emission"],
				island_data["population"],
				island_data["development"]
			)
			EmissionRateStatusPopup.StatusPopup(null, null)
	else:
		EmissionRateStatusPopup.HideStatusPopup()
