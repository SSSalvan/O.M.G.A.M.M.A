extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_play_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_gameplay_diff_easy.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()
