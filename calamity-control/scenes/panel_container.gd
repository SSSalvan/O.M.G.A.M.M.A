extends PanelContainer

func _draw():
	var rect = Rect2(Vector2(5, 20), Vector2(70, 50))  # Position & size
	var color = Color(0, 0, 0)  # Red color
	var thickness = 0.2  # Line thickness
	
	draw_rect(rect, color, false, thickness)  # false = no fill
