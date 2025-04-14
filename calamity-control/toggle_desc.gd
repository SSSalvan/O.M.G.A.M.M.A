extends Button

func _on_toggle_desc_toggled(toggled_on: bool) -> void:
	$Panel/PanelSuryaDesc.visible = toggled_on
