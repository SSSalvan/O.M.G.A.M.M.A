extends GutTest

var game_scene

func before_each():
	game_scene = preload("res://scenes/main_gameplay.tscn").instantiate()

func after_each():
	game_scene.queue_free()

func test_initial_resource_equals_1000():
	assert_eq(ResourceCount.resource, 1000, "Initial resource should be 1000")

func test_end_week_resource_increase():
	var game_manager = game_scene.get_node("GameManager")
	game_manager.weekly_income_resource()
	assert_eq(ResourceCount.resource, 1500, "Resource should be increased to 1500")
