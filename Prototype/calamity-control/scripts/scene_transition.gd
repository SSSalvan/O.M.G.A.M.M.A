extends CanvasLayer

func change_scene(target: String) -> void:
	if $AnimationPlayer:
		$AnimationPlayer.play("dissolve")  # Play the animation
		await $AnimationPlayer.animation_finished  # Wait for animation to complete
		get_tree().change_scene_to_file(target)  # Switch scene
		$AnimationPlayer.play_backwards("dissolve")  # Play animation backwards
	else:
		print("ERROR: AnimationPlayer not found!")  # Debugging info
