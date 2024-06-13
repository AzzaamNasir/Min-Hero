extends Node
## Data Object, stores the player's data

@export var run_speed := 300

var player_sprite : SpriteFrames = preload("res://characters/player/assets/male/anim_sprite.tres")
var unlocked_minions : Array[MinionData]
var team : Array[MinionData]
var health := 0
var attack := 0
var energy := 0
var healing := 0
var speed := 0
var exp := 0
var extra_money := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
