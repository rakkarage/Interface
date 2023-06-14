extends Control

@onready var _buttonIn: Button = $In
@onready var _buttonOut: Button = $Out
@onready var _mask := get_tree().current_scene

func _ready():
	_buttonIn.connect("pressed", Callable(_mask, "animateIn"))
	_buttonOut.connect("pressed", Callable(_mask, "animateOut"))
