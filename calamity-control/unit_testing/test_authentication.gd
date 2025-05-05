extends GutTest

var register_scene
var rng := RandomNumberGenerator.new()

# Path to the JSON file
var json_path = "res://User/users.json"
var json_backup_path = "res://User/users_backup.json"

func before_each():
	register_scene = preload("res://scenes/register.tscn").instantiate()
	add_child(register_scene)

	if FileAccess.file_exists(json_path):
		var file = FileAccess.open(json_path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var backup_file = FileAccess.open(json_backup_path, FileAccess.WRITE)
		backup_file.store_string(content)
		backup_file.close()

	rng.randomize()
	await get_tree().process_frame
	register_scene.visible = true
	await get_tree().process_frame

func after_each():
	if FileAccess.file_exists(json_backup_path):
		var backup_file = FileAccess.open(json_backup_path, FileAccess.READ)
		var content = backup_file.get_as_text()
		backup_file.close()
		var file = FileAccess.open(json_path, FileAccess.WRITE)
		file.store_string(content)
		file.close()

	if is_instance_valid(register_scene):
		register_scene.queue_free()

func _get_username_input(): return register_scene.get_node("register_panel/username_input")
func _get_password_input(): return register_scene.get_node("register_panel/password_input")
func _get_reenter_password_input(): return register_scene.get_node("register_panel/re_enter_password_input")
func _get_confirm_button(): return register_scene.get_node("register_panel/confirm")
func _get_error_label(): return register_scene.get_node("register_panel/error_handling")

func _set_text(node, text):
	node.text = text
	await get_tree().process_frame

func _press_button(button):
	if button.has_signal("pressed"):
		button.emit_signal("pressed")
	else:
		push_error("Button does not have a 'pressed' signal!")
	await get_tree().process_frame

func _generate_random_string(length: int) -> String:
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
	var str = ""
	for i in length:
		str += chars[rng.randi_range(0, chars.length() - 1)]
	return str

func test_successful_registration():
	for i in range(5):
		print("test :", i+1)
		var username = _generate_random_string(8)
		var password = _generate_random_string(10)
		print("Username: " + username, " Password: " + password)
		await _set_text(_get_username_input(), username)
		await _set_text(_get_password_input(), password)
		await _set_text(_get_reenter_password_input(), password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Registered successfully!", "Should register successfully")
		assert_true(UserData.users.has(username), "User should be added to users")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")

func test_username_already_exists():
	for i in range(5):
		print("test :", i+1)
		var existing_username = "bismatesting"
		var new_password = _generate_random_string(10)
		print("Username: " + existing_username, " Password: " + new_password)
		await _set_text(_get_username_input(), existing_username)
		await _set_text(_get_password_input(), new_password)
		await _set_text(_get_reenter_password_input(), new_password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Username already exists.", "Should show 'Username already exists' error")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")

func test_short_username():
	for i in range(5):
		print("test :", i+1)
		var short_username = _generate_random_string(7)
		var password = _generate_random_string(10)
		print("Username: " + short_username, " Password: " + password)
		await _set_text(_get_username_input(), short_username)
		await _set_text(_get_password_input(), password)
		await _set_text(_get_reenter_password_input(), password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Username must be at least 8 characters long.", "Should show short username error")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")

func test_invalid_username_characters():
	for i in range(5):
		print("test :", i+1)
		var invalid_username = "invalid!" + _generate_random_string(5)
		var password = _generate_random_string(10)
		print("Username: " + invalid_username, " Password: " + password)
		await _set_text(_get_username_input(), invalid_username)
		await _set_text(_get_password_input(), password)
		await _set_text(_get_reenter_password_input(), password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Username can only contain letters, numbers, and underscores.", "Should show invalid username characters error")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")

func test_short_password():
	for i in range(5):
		print("test :", i+1)
		var username = _generate_random_string(8)
		var short_password = _generate_random_string(7)
		print("Username: " + username, " Password: " + short_password)
		await _set_text(_get_username_input(), username)
		await _set_text(_get_password_input(), short_password)
		await _set_text(_get_reenter_password_input(), short_password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Password must be at least 8 characters long.", "Should show short password error")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")

func test_password_mismatch():
	for i in range(5):
		print("test :", i+1)
		var username = _generate_random_string(8)
		var password = _generate_random_string(10)
		var mismatched_password = _generate_random_string(9)
		print("Username: " + username, " Password: " + password, " Mismatched Password: " + mismatched_password)
		await _set_text(_get_username_input(), username)
		await _set_text(_get_password_input(), password)
		await _set_text(_get_reenter_password_input(), mismatched_password)
		await _press_button(_get_confirm_button())
		assert_eq(_get_error_label().text, "Passwords do not match.", "Should show password mismatch error")
		await _set_text(_get_username_input(), "")
		await _set_text(_get_password_input(), "")
		await _set_text(_get_reenter_password_input(), "")
