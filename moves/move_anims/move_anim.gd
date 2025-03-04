class_name MoveAnim extends Resource

signal anim_ended

var owner: Node2D

@export var anim_end := true
@export var sequential := false
@export var duration := 2.0
@export var asset_idx := 0

func _init() -> void:
	resource_local_to_scene = true

func setup(node_owner: Node2D):
	owner = node_owner

func play(_tween: Tween):
	pass
