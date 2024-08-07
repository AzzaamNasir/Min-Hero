@tool
extends Node2D
class_name MoveAnimator

var tween : Tween
@export var animations : Array[MoveAnim]

func _ready() -> void:
	animations.clear()
	animations.append_array(get_children())
	if not Engine.is_editor_hint():
		play()

func play():
	for anim in animations:
		await anim.animation.call()
