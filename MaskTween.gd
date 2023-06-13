extends Control
class_name MaskTween

@onready var _mask: ColorRect = $Mask

const _tweenTime = 1.0
const _scaleMin = 0.0
const _scaleMax = 1000.0
const _colorMin = Color(0, 0, 0, 0)
const _colorMax = Color(0, 0, 0, 1)

func animateIn() -> void:
	var scaleCurrent = _mask.material.get_shader_parameter("scale")
	var colorCurrent = _mask.material.get_shader_parameter("color")
	var tween := create_tween()
	tween.tween_callback(func(): _mask.mouse_filter = Control.MOUSE_FILTER_STOP)
	tween.tween_method(_setShaderScale, scaleCurrent, _scaleMax, _tweenTime).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.parallel().tween_method(_setShaderColor, colorCurrent, _colorMax, _tweenTime).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await tween.finished

func animateOut() -> void:
	var scaleCurrent = _mask.material.get_shader_parameter("scale")
	var colorCurrent = _mask.material.get_shader_parameter("color")
	var tween := create_tween()
	tween.tween_method(_setShaderScale, scaleCurrent, _scaleMin, _tweenTime).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_method(_setShaderColor, colorCurrent, _colorMin, _tweenTime).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_callback(func(): _mask.mouse_filter = Control.MOUSE_FILTER_IGNORE)
	await tween.finished

func _setShaderColor(newColor: Color) -> void:
	_mask.material.set_shader_parameter("color", newColor)

func _setShaderScale(newScale: float) -> void:
	_mask.material.set_shader_parameter("scale", newScale)
