extends CanvasLayer

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


func _on_buy_panel_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[0]:
		ShopItems.itemCount[0] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[0])
		print("Bought, now ", ShopItems.itemCount[0], " Solar Panel")
		item0Label.text = "%d" % ShopItems.itemCount[0]

func _on_buy_turbin_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[1]:
		ShopItems.itemCount[1] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[1])
		print("Bought, now ", ShopItems.itemCount[1], " Wind Turbine")
		item1Label.text = "%d" % ShopItems.itemCount[1]

func _on_buy_education_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[2]:
		ShopItems.itemCount[2] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[2])
		print("Bought, now ", ShopItems.itemCount[2], " Climate Education")
		item2Label.text = "%d" % ShopItems.itemCount[2]

func _on_buy_reforestation_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[3]:
		ShopItems.itemCount[3] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[3])
		print("Bought, now ", ShopItems.itemCount[3], " Rainforest Restoration")
		item3Label.text = "%d" % ShopItems.itemCount[3]

func _on_buy_energy_plant_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[4]:
		ShopItems.itemCount[4] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[4])
		print("Bought, now ", ShopItems.itemCount[4], " Waste-to-Energy Plant")
		item4Label.text = "%d" % ShopItems.itemCount[4]

func _on_buy_electric_vehicle_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[5]:
		ShopItems.itemCount[5] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[5])
		print("Bought, now ", ShopItems.itemCount[5], " Electric Vehicle Subsidy")
		item5Label.text = "%d" % ShopItems.itemCount[5]

func _on_buy_green_building_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[6]:
		ShopItems.itemCount[6] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[6])
		print("Bought, now ", ShopItems.itemCount[6], " Green Building")
		item6Label.text = "%d" % ShopItems.itemCount[6]

func _on_buy_carbon_conservation_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[7]:
		ShopItems.itemCount[7] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[7])
		print("Bought, now ", ShopItems.itemCount[7], " Blue Carbon Conservation")
		item7Label.text = "%d" % ShopItems.itemCount[7]

func _on_buy_cleanup_drone_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[8]:
		ShopItems.itemCount[8] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[8])
		print("Bought, now ", ShopItems.itemCount[8], " Ocean Clean-up Drone")
		item8Label.text = "%d" % ShopItems.itemCount[8]

func _on_buy_storage_dome_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[9]:
		ShopItems.itemCount[9] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[9])
		print("Bought, now ", ShopItems.itemCount[9], " Carbon Storage Dome")
		item9Label.text = "%d" % ShopItems.itemCount[9]

func _on_buy_soil_restoration_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[10]:
		ShopItems.itemCount[10] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[10])
		print("Bought, now ", ShopItems.itemCount[10], " Soil Restoration Kit")
		item10Label.text = "%d" % ShopItems.itemCount[10]

func _on_buy_anti_erosion_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[11]:
		ShopItems.itemCount[11] += 1
		ResourceCount.subtract_money(ShopItems.itemPrice[11])
		print("Bought, now ", ShopItems.itemCount[11], " Anti-Erosion Barrier")
		item11Label.text = "%d" % ShopItems.itemCount[11]
