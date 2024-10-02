extends Control
class_name MaskTween

@onready var _mask: ColorRect = $Mask

@export var _duration = 1.0
@export var _scale_min = 0.0
@export var _scale_max = 1000.0
@export var _color_min = Color(0, 0, 0, 0)
@export var _color_max = Color(0, 0, 0, 1)

func animate_in() -> void:
	var scale_current = _mask.material.get_shader_parameter("scale")
	var color_current = _mask.material.get_shader_parameter("color")
	var tween := create_tween()
	tween.tween_callback(func() -> void: _mask.mouse_filter = Control.MOUSE_FILTER_STOP)
	tween.tween_method(_set_shader_scale, scale_current, _scale_max, _duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.parallel().tween_method(_set_shader_color, color_current, _color_max, _duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await tween.finished

func animate_out() -> void:
	var scale_current = _mask.material.get_shader_parameter("scale")
	var color_current = _mask.material.get_shader_parameter("color")
	var tween := create_tween()
	tween.tween_method(_set_shader_scale, scale_current, _scale_min, _duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_method(_set_shader_color, color_current, _color_min, _duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_callback(func() -> void: _mask.mouse_filter = Control.MOUSE_FILTER_IGNORE)
	await tween.finished

func _set_shader_color(newColor: Color) -> void:
	_mask.material.set_shader_parameter("color", newColor)

func _set_shader_scale(newScale: float) -> void:
	_mask.material.set_shader_parameter("scale", newScale)
