extends CanvasLayer

# Labels for item quantities
@onready var item0Label: Label = $BG_ShopPanel/PanelSurya/QuantityPanel
@onready var item1Label: Label = $BG_ShopPanel/TurbinAngin/QuantityTurbin
@onready var item2Label: Label = $BG_ShopPanel/ClimateEducation/QuantityEducation
@onready var item3Label: Label = $BG_ShopPanel/RainforestRestoration/QuantityReforestation
@onready var item4Label: Label = $BG_ShopPanel/WastetoEnergyPlant/QuantityEnergyPlant
@onready var item5Label: Label = $BG_ShopPanel/ElectricVehicleSubsidy/QuantityElectricVehicle
@onready var item6Label: Label = $BG_ShopPanel/GreenBuilding/QuantityGreenBuilding
@onready var item7Label: Label = $BG_ShopPanel/BlueCarbonConservation/QuantityCarbonConservation
@onready var item8Label: Label = $BG_ShopPanel/OceanCleanupDrone/QuantityCleanupDrone
@onready var item9Label: Label = $BG_ShopPanel/CarbonStorageDome/QuantityStorageDome
@onready var item10Label: Label = $BG_ShopPanel/SoilRestorationKit/QuantitySoilRestoration
@onready var item11Label: Label = $BG_ShopPanel/AntiErosionBarrier/QuantityAntiErosion

# Labels for item prices
@onready var price0Label: Label = $BG_ShopPanel/PanelSurya/PricePanel
@onready var price1Label: Label = $BG_ShopPanel/TurbinAngin/PriceTurbin
@onready var price2Label: Label = $BG_ShopPanel/ClimateEducation/PriceEducation
@onready var price3Label: Label = $BG_ShopPanel/RainforestRestoration/PriceReforestation
@onready var price4Label: Label = $BG_ShopPanel/WastetoEnergyPlant/PriceEnergyPlant
@onready var price5Label: Label = $BG_ShopPanel/ElectricVehicleSubsidy/PriceElectricVehicle
@onready var price6Label: Label = $BG_ShopPanel/GreenBuilding/PriceGreenBuilding
@onready var price7Label: Label = $BG_ShopPanel/BlueCarbonConservation/PriceCarbonConservation
@onready var price8Label: Label = $BG_ShopPanel/OceanCleanupDrone/PriceCleanupDrone
@onready var price9Label: Label = $BG_ShopPanel/CarbonStorageDome/PriceStorageDome
@onready var price10Label: Label = $BG_ShopPanel/SoilRestorationKit/PriceSoilRestoration
@onready var price11Label: Label = $BG_ShopPanel/AntiErosionBarrier/PriceAntiErosion

func _ready():
	# Set up price labels
	price0Label.text = "Price: %d" % ShopItems.itemPrice[0]
	price1Label.text = "Price: %d" % ShopItems.itemPrice[1]
	price2Label.text = "Price: %d" % ShopItems.itemPrice[2]
	price3Label.text = "Price: %d" % ShopItems.itemPrice[3]
	price4Label.text = "Price: %d" % ShopItems.itemPrice[4]
	price5Label.text = "Price: %d" % ShopItems.itemPrice[5]
	price6Label.text = "Price: %d" % ShopItems.itemPrice[6]
	price7Label.text = "Price: %d" % ShopItems.itemPrice[7]
	price8Label.text = "Price: %d" % ShopItems.itemPrice[8]
	price9Label.text = "Price: %d" % ShopItems.itemPrice[9]
	price10Label.text = "Price: %d" % ShopItems.itemPrice[10]
	price11Label.text = "Price: %d" % ShopItems.itemPrice[11]

func _process(_delta):
	item0Label.text = "%d" % ShopItems.get_item_count(0)
	item1Label.text = "%d" % ShopItems.get_item_count(1)
	item2Label.text = "%d" % ShopItems.get_item_count(2)
	item3Label.text = "%d" % ShopItems.get_item_count(3)
	item4Label.text = "%d" % ShopItems.get_item_count(4)
	item5Label.text = "%d" % ShopItems.get_item_count(5)
	item6Label.text = "%d" % ShopItems.get_item_count(6)
	item7Label.text = "%d" % ShopItems.get_item_count(7)
	item8Label.text = "%d" % ShopItems.get_item_count(8)
	item9Label.text = "%d" % ShopItems.get_item_count(9)
	item10Label.text = "%d" % ShopItems.get_item_count(10)
	item11Label.text = "%d" % ShopItems.get_item_count(11)

# Standardized buy functions
func _on_buy_panel_pressed(): buy_item(0, "Solar Panel")
func _on_buy_turbin_pressed(): buy_item(1, "Wind Turbine")
func _on_buy_education_pressed(): buy_item(2, "Climate Education")
func _on_buy_reforestation_pressed(): buy_item(3, "Rainforest Restoration")
func _on_buy_energy_plant_pressed(): buy_item(4, "Waste-to-Energy Plant")
func _on_buy_electric_vehicle_pressed(): buy_item(5, "Electric Vehicle Subsidy")
func _on_buy_green_building_pressed(): buy_item(6, "Green Building")
func _on_buy_carbon_conservation_pressed(): buy_item(7, "Blue Carbon Conservation")
func _on_buy_cleanup_drone_pressed(): buy_item(8, "Ocean Clean-up Drone")
func _on_buy_storage_dome_pressed(): buy_item(9, "Carbon Storage Dome")
func _on_buy_soil_restoration_pressed(): buy_item(10, "Soil Restoration Kit")
func _on_buy_anti_erosion_pressed(): buy_item(11, "Anti-Erosion Barrier")

func buy_item(index: int, name: String) -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[index]:
		ShopItems.add_item(index, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[index])
		print("Bought, now ", ShopItems.get_item_count(index), " ", name)
		print("Full inventory:", ShopItems.itemCount)

func refresh_item_labels():
	item0Label.text = "%d" % ShopItems.get_item_count(0)
	item1Label.text = "%d" % ShopItems.get_item_count(1)
	item2Label.text = "%d" % ShopItems.get_item_count(2)
	item3Label.text = "%d" % ShopItems.get_item_count(3)
	item4Label.text = "%d" % ShopItems.get_item_count(4)
	item5Label.text = "%d" % ShopItems.get_item_count(5)
	item6Label.text = "%d" % ShopItems.get_item_count(6)
	item7Label.text = "%d" % ShopItems.get_item_count(7)
	item8Label.text = "%d" % ShopItems.get_item_count(8)
	item9Label.text = "%d" % ShopItems.get_item_count(9)
	item10Label.text = "%d" % ShopItems.get_item_count(10)
	item11Label.text = "%d" % ShopItems.get_item_count(11)

func item_buy_test(number: int):
	match number:
		0:
			_on_buy_panel_pressed()
		1:
			_on_buy_turbin_pressed()
		2:
			_on_buy_education_pressed()
		3:
			_on_buy_reforestation_pressed()
		4:
			_on_buy_energy_plant_pressed()
		5:
			_on_buy_electric_vehicle_pressed()
		6:
			_on_buy_green_building_pressed()
		7:
			_on_buy_carbon_conservation_pressed()
		8:
			_on_buy_cleanup_drone_pressed()
		9:
			_on_buy_storage_dome_pressed()
		10:
			_on_buy_soil_restoration_pressed()
		11:
			_on_buy_anti_erosion_pressed()
		_:
			print("Invalid item number:", number)
