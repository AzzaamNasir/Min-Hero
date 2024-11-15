class_name Opponent
extends StaticBody2D
## This class contains Contains all the enemies. It will be treated more as a data
## object and a bridge, the main code(Dialogue and all is in the OpponentDialogue Class)

## Only useful for sideways sprites usually
@export var flip_sprite := false
@export var opponent_name : String
@export var sprite : Texture2D
## Dialogue before the fight
@export_multiline var pregame_dialogue : String
## Dialogue after the fight
@export_multiline var postgame_dialogue : String

var player: Player

var defeated : bool = false
var in_range : bool = false

@onready var dialogue_box := $DialogueBox

func _ready() -> void:
	$Sprite.texture = sprite
	$Sprite.flip_h = flip_sprite
	dialogue_box.dialogue_finished.connect(func(): player.switch_state(player.States.NORMAL))

func _input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("interact"):
		if not dialogue_box.active:
			dialogue_box.show_dialogue(opponent_name, pregame_dialogue)
			player.switch_state(player.States.STOPPED)
		else:
			dialogue_box.progress_dialogue()

func _on_range_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		in_range = true
		UIData.show_interact = true

func _on_range_exited(body: Node2D) -> void:
	if body is Player:
		in_range = false
		UIData.show_interact = false
