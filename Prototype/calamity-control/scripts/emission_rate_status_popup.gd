extends Control

@onready var status_label: Label = $UI/EmissionRatePopUp/VBoxContainer/status_report_island_name
@onready var emission_rate_label: Label = $UI/EmissionRatePopUp/VBoxContainer/emission_rate
@onready var population_label: Label = $UI/EmissionRatePopUp/VBoxContainer/population_count
@onready var development_label: Label = $UI/EmissionRatePopUp/VBoxContainer/development_level
@onready var emission_rate_popup: Window = $UI/EmissionRatePopUp

var status_report_island: String
var emission_rate: int
var population_count: int
var development_level: int

func StatusPopup(_slot, _item):
	emission_rate_popup.popup()

func HideStatusPopup():
	emission_rate_popup.hide()

func update_status(island_name: String, emission: int, population: int, development: int):
	status_report_island = island_name
	emission_rate = emission
	population_count = population
	development_level = development
	
	status_label.text = "Status Report: %s" % island_name
	emission_rate_label.text = "Emission Rate: %d%%" % emission
	population_label.text = "Population: %d" % population
	development_label.text = "Development Level: %d" % development
