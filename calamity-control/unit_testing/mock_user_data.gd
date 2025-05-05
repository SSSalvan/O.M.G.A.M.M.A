# res://scripts/mock_user_data.gd
extends Node

# Simulated user database
var users = {
	"existing_user": {
		"password": "password123",
		"total_playtime": 100.0,
		"games_won": 5,
		"games_lost": 3
	},
	"test_user": {
		"password": "testpass",
		"total_playtime": 50.0,
		"games_won": 2,
		"games_lost": 1
	}
}
var current_user: String = ""

func register_user(username: String, password: String) -> bool:
	if users.has(username):
		return false
	users[username] = {
		"password": password,
		"total_playtime": 0.0,
		"games_won": 0,
		"games_lost": 0
	}
	return true

func validate_login(username: String, password: String) -> bool:
	if users.has(username) and users[username].has("password") and users[username]["password"] == password:
		current_user = username
		return true
	return false

func get_user_data(username: String) -> Dictionary:
	if users.has(username):
		return users[username]
	return {}

func set_user_data(username: String, data: Dictionary) -> void:
	if users.has(username):
		users[username] = data

func add_win(username: String):
	if users.has(username):
		users[username].games_won += 1

func add_loss(username: String):
	if users.has(username):
		users[username].games_lost += 1

func add_playtime(username: String, playtime: float):
	if users.has(username):
		users[username].total_playtime += playtime
