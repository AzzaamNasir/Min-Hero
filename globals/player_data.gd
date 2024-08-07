extends Node
## Data Object, stores the player's data

@export var run_speed := 450

var player_sprite : SpriteFrames = preload("res://characters/player/assets/male/anim_sprite.tres")
var unlocked_minions : Array[Minion]
var team : Array[Minion]
var health := 0
var attack := 0
var energy := 0
var healing := 0
var speed := 0
var exp_points := 0
var extra_money := 0
