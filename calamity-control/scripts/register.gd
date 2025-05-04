extends CanvasLayer

@onready var username_input = $register_panel/username_input
@onready var password_input = $register_panel/password_input
@onready var re_enter_password_input = $register_panel/"re-enter_password_input"

func _on_register_button_pressed():
	var username = username_input.text.strip_edges()
	var password = password_input.text
	var re_password = re_enter_password_input.text

	if username == "" or password == "":
		show_error("Username and password cannot be empty.")
		return

	if password != re_password:
		show_error("Passwords do not match.")
		return

	if not UserData.register_user(username, password):
		show_error("Username already exists.")
		return

	show_success("Registration successful.")
	hide()  # Or switch to login screen

func show_error(message: String):
	print("Error:", message)  # You can replace this with a Label or Popup

func show_success(message: String):
	print("Success:", message)
