extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()  # Get global mouse position

		# Ensure the shape exists and check if mouse is inside
		if shape and shape is CapsuleShape2D:
			var local_mouse = to_local(mouse_pos)
			var capsule_radius = shape.radius
			var capsule_height = shape.height

			# Check if the mouse is within the capsule's bounding area
			if abs(local_mouse.x) <= capsule_radius and abs(local_mouse.y) <= capsule_height * 0.5:
				print("Clicked inside Capsule! Switching scene...")
				SceneTransition.change_scene("res://src/scenes/main_menu.tscn")
