extends Node

var users = {}
var current_user: String = ""

func _ready():
	load_users() # Load users from JSON when the game starts

func register_user(username: String, password: String) -> bool:
	if users.has(username):
		return false
	users[username] = {
		"password": password,
		"total_playtime": 0.0,
		"games_won": 0,
		"games_lost": 0
	}
	save_users()
	return true

func validate_login(username: String, password: String) -> bool:
	if users.has(username) and users[username].has("password") and users[username]["password"] == password:
		current_user = username
		return true
	return false

func save_users() -> void:
	var file = FileAccess.open("res://User/users.json", FileAccess.WRITE)
	var save_data = {}
	for user in users:
		save_data[user] = {
			"password": users[user].password,
			"total_playtime": users[user].total_playtime,
			"games_won": users[user].games_won,
			"games_lost": users[user].games_lost
		}
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

func load_users() -> void:
	var path = "res://User/users.json"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var content = file.get_as_text()
		var parsed = JSON.parse_string(content)
		if parsed is Dictionary:
			users = parsed
		else:
			printerr("Error loading users.json: Invalid JSON format.")
	else:
		print("Warning: users.json not found. Starting with an empty user database.")

func get_user_data(username: String) -> Dictionary:
	if users.has(username):
		return users[username]
	return {}

func set_user_data(username: String, data: Dictionary) -> void:
	if users.has(username):
		users[username] = data
		save_users()

func add_win(username: String):
	if users.has(username):
		users[username].games_won += 1
		save_users()

func add_loss(username: String):
	if users.has(username):
		users[username].games_lost += 1
		save_users()

func add_playtime(username: String, playtime: float):
	if users.has(username):
		users[username].total_playtime += playtime
		save_users()
