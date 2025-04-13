extends CanvasLayer


func _on_close_shop_pressed() -> void:
	get_tree().paused = true
	get_node("Animation").play("Out")
