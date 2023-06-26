extends Control

@onready var _button_in: Button = $In
@onready var _button_out: Button = $Out
@onready var _mask := get_tree().current_scene

func _ready():
	_button_in.connect("pressed", Callable(_mask, "animate_in"))
	_button_out.connect("pressed", Callable(_mask, "animate_out"))
