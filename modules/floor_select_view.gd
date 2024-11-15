extends Node2D

@export var is_bonus := false
@export var background_sprite : Texture2D
@export var area_num_sprite : Texture2D
@export var floor_num_sprite : Texture2D
@export var bonus_sprite : Texture2D


func _ready() -> void:
	%Background.texture = background_sprite
	if is_bonus:
		%Bonus.texture = bonus_sprite 
	%AreaNumber.texture = area_num_sprite
	%FloorNumber.texture = floor_num_sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
