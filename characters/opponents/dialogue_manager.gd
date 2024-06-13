extends Panel
class_name OpponentDialogue
## manages the dialogs

signal dialogue_complete
# This can be used to check whether the end of label has been reached
var dialogue_count := 0

# Label on which name is drawn
@onready var name_label: RichTextLabel = $Name
# Label on which dialogue is written
@onready var dialogue: RichTextLabel = $Dialogue
# The small arrow which tells you if there is more text
@onready var continuation_indicator: TextureRect = $ContinuationIndicator


# This is where the actual dialogue rendering happens
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if dialogue_count > 0:# if dialogs have started, do this:
			var lines = dialogue.get_line_count()
			if dialogue_count > lines - dialogue.get_visible_line_count() + 1:
				hide_dialogue()# THis is the max number of lines dilogue can scroll
				return
			var scroll_bar = dialogue.get_v_scroll_bar()
			var max_scroll = scroll_bar.max_value
			get_tree().create_tween().tween_property(scroll_bar,"value"\
			,scroll_bar.value + (max_scroll / dialogue.get_line_count()),0.2)
			
			# If on last scroll remove the contonue indicator
			if (
				(lines - dialogue.get_visible_line_count()) * (max_scroll / lines)\
				> scroll_bar.value - max_scroll / lines
				):
				continuation_indicator.visible = false
			
			dialogue_count += 1

func show_dialogue():
	name_label.text = "[center]" + owner.opponent_name
	dialogue.text = owner.pregame_dialogue
	modulate.a = 0
	show()
	get_tree().create_tween().tween_property(self,"modulate:a",1,0.2)
	dialogue_count += 1

func hide_dialogue():
	var tweener = get_tree().create_tween()
	tweener.tween_property(self,"modulate:a",0,0.2)
	await tweener.finished
	hide()
	continuation_indicator.show()
	dialogue_count = 0
	dialogue.get_v_scroll_bar().value = 0
	TempData.dialogue_complete.emit()
