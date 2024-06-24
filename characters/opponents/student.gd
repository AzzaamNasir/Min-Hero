class_name Opponent
extends StaticBody2D
## This class contains Contains all the enemies. It will be treated more as a data
## object and a bridge, the main code(Dialogue and all is in the OpponentDialogue Class)

@export var flip_sprite := false
@export var opponent_name : String
@export var sprite : Texture2D
@export var minions : Array
@export_multiline var pregame_dialogue : String
@export_multiline var postgame_dialogue : String

var defeated : bool = false

@onready var dialogue_box: OpponentDialogue = $DialogueBox

func _ready() -> void:
	$Sprite.texture = sprite
	$Sprite.flip_h = flip_sprite

func dialog_start():
	if dialogue_box.dialogue_count == -1:
		dialogue_box.show_dialogue()
