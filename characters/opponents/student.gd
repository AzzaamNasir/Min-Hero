class_name Opponent
extends StaticBody2D

@export var opponent_name : String
@export var minions : Array
@export_multiline var pregame_dialogue : String
@export_multiline var postgame_dialogue : String

@onready var dialogue_box: Panel = %DialogueBox
@onready var name_label: RichTextLabel = %Name
@onready var dialogue_label: RichTextLabel = %Dialogue

var defeated : bool = false

func show_dialogue():
	name_label.text = "[center]" + opponent_name
	
	match defeated:
		false:
			dialogue_label.text = pregame_dialogue
	
	dialogue_box.modulate.a = 0
	dialogue_box.show()
	get_tree().create_tween().tween_property(dialogue_box,"modulate:a",1,0.2)
