extends CharacterBody2D

var dir := Vector2(0,0)
var in_interact_range := false
var interactable : Node2D

@onready var anim_tree : AnimationTree = %AnimationTree
@onready var sprite := %Sprite

func _ready():
	sprite.sprite_frames = PlayerData.player_sprite

func _physics_process(delta):
	dir = Input.get_vector("key_left","key_right","key_up","key_down")
	velocity = dir * PlayerData.run_speed
	anim_tree.set("parameters/conditions/idle",velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/moving",velocity != Vector2.ZERO)
	
	if not dir == Vector2.ZERO:
		anim_tree.set("parameters/moving/blend_position",dir)
		anim_tree.set("parameters/idle/blend_position",dir)
		move_and_slide()
		UIData.show_keys = false
	
	if Input.is_action_just_pressed("ui_select") and in_interact_range == true:
		if interactable is Opponent:
			interactable.show_dialogue()

func _on_interactable_entered(body: Node2D) -> void:
	interactable = body
	in_interact_range = true
	UIData.show_interact = true


func _on_interactable_exited(body: Node2D) -> void:
	in_interact_range = false
	UIData.show_interact = false
