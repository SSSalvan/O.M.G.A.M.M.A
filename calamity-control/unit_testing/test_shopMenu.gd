extends GutTest
var shop_scene

func before_each():
	shop_scene = preload("res://scenes/ShopPanel.tscn").instantiate()
	ResourceCount.resource=900000

func after_each():
	shop_scene.queue_free()

func test_itemname():
	var shop = shop_scene.get_node("ShopPanel")
	var arr: Array[int] = []
	arr.resize(12)
	for i in range(50): 
		print ("Buy item #", i)
		var random_int = randi_range(0, 11)
		arr[random_int]+=1
		shop_scene.item_buy_test(random_int)
	
	for i in range(12):
		assert_eq(arr[i], ShopItems.itemCount[i], "Item quantity should be the correct amount")
