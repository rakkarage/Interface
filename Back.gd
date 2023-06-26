@tool
extends TextureRect

var _parent : Control

const _r := PI / 2.0

func _ready() -> void:
	_parent = get_parent()
	_parent.connect("resized", _on_resized)
	_on_resized()

func _on_resized() -> void:
	if _parent.size.x > _parent.size.y:
		rotation = _r
		scale = Vector2(_parent.size.y / size.x, _parent.size.x / size.y)
	else:
		rotation = 0
		scale = Vector2(_parent.size.x / size.x, _parent.size.y / size.y)
