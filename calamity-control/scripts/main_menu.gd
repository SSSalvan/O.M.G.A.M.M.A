extends Control

func _ready() -> void:
	pass

func _on_play_game_pressed() -> void:
		get_tree().paused = true
		get_node("/root/LevelDifficultiesSelect/.").visible = true
		get_node("/root/LevelDifficultiesSelect/level_diff_anim").play("Transition_In_level_diff")
		get_tree().paused = false


func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_credts_pressed() -> void:
	var credits = preload("res://scenes/credits_scene.tscn").instantiate()
	add_child(credits)

func _on_login_pressed() -> void:
	var login_scene = preload("res://scenes/login_panel.tscn").instantiate()
	add_child(login_scene)
	login_scene.visible = true

func _on_register_pressed() -> void:
	var register_scene = preload("res://scenes/register.tscn").instantiate()
	add_child(register_scene)
	register_scene.visible = true


func is_user_logged_in() -> bool:
	return UserData.current_user != ""

func _on_user_profile_pressed() -> void:
	var char_details = preload("res://scenes/user_profile.tscn").instantiate()
	add_child(char_details)
	char_details.visible = true
