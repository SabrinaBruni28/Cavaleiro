@tool
extends Control

@onready var slider_volume: HSlider = $SliderVolume
@onready var label: Label = $Label

@export var bus_name: String = "Master"
@export var label_nome: String
@export var largura: float
var bus_index: int 

func _ready() -> void:
	label.text = label_nome
	slider_volume.size.x = largura
	bus_index = AudioServer.get_bus_index(bus_name)
	slider_volume.value_changed.connect(_on_value_changed)
	slider_volume.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
