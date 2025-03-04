extends Node2D
class_name Move

signal move_finished # This signals to move onto the next animation
signal move_actually_finished # This signals when the sprite can be removed

@export var move_data: MoveData

@export_category("Move Animation")
@export var sequential_anim := true
@export var animations: Array[MoveAnim]

func _ready() -> void:
	pass

func play(idx: int) -> void:
	var cur_anim = animations.slice(idx)
	for anim: MoveAnim in cur_anim:
		var tween: Tween = get_tree().create_tween()
		anim.setup(self)
		anim.play(tween)
		
		if anim.sequential or anim.anim_end: 
			await anim.anim_ended
