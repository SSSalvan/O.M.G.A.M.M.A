extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_play_game_pressed() -> void:
	get_tree().paused = true
	get_node("/root/LevelDifficultiesSelect/.").visible = true
	get_node("/root/LevelDifficultiesSelect/level_diff_anim").play("Transition_In_level_diff")
	get_tree().paused = false
	
	
func _on_exit_game_pressed() -> void:
	get_tree().quit()
