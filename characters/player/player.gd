extends CharacterBody2D
class_name Player

enum States {NORMAL, STOPPED}

var state: States = States.NORMAL

var dir := Vector2(0,0) # Direction
var in_interact_range := false # Is the player in range of an interactable
var interactable : Node2D # The node player is in range of

@onready var anim_tree := %AnimationTree
@onready var sprite := %Sprite

func _ready():
	sprite.sprite_frames = PlayerData.player_sprite

func _physics_process(delta):
	match state:
		States.NORMAL:
			_phy_process_normal(delta)

func switch_state(new_state: States):
	state = new_state

#region States.NORMAL
func _phy_process_normal(_delta: float):
	dir = Input.get_vector("key_left","key_right","key_up","key_down")
	velocity = dir * PlayerData.run_speed 
	anim_tree.set("parameters/conditions/idle",velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/moving",velocity != Vector2.ZERO)
	
	if not dir == Vector2.ZERO:
		anim_tree.set("parameters/moving/blend_position",dir)
		anim_tree.set("parameters/idle/blend_position",dir)
		UIData.show_keys = false
		
	move_and_slide()
#endregion
