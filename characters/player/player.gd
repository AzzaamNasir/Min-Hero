extends CharacterBody2D

var dir := Vector2(0,0) # Direction
var in_interact_range := false # Is the player in range of an interactable
var interactable : Node2D # The node player is in range of
var talking = false

@onready var anim_tree : AnimationTree = %AnimationTree
@onready var sprite := %Sprite

func _ready():
	sprite.sprite_frames = PlayerData.player_sprite
	SignalBus.dialogue_started.connect(func():
		talking = true
		)
	
	SignalBus.dialogue_complete.connect(func():
		talking = false
		)

func _physics_process(delta):
	#region Moving+Animating player
	dir = Input.get_vector("key_left","key_right","key_up","key_down") if not talking else Vector2.ZERO
	velocity = Vector2.ZERO if talking else dir * PlayerData.run_speed 
	anim_tree.set("parameters/conditions/idle",velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/moving",velocity != Vector2.ZERO)
	
	if not dir == Vector2.ZERO:
		anim_tree.set("parameters/moving/blend_position",dir)
		anim_tree.set("parameters/idle/blend_position",dir)
		UIData.show_keys = false
		
	move_and_slide()
	#endregion
