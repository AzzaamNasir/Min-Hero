extends Panel
class_name OpponentDialogue
## manages the dialogs

signal dialogue_complete
# This can be used to check whether the end of label has been reached
var dialogue_count := -1
# Label on which name is drawn
@onready var name_label: RichTextLabel = $Name
# Label on which dialogue is written
@onready var dialogue: RichTextLabel = $Dialogue
# The small arrow which tells you if there is more text
@onready var continuation_indicator: TextureRect = $ContinuationIndicator

func _ready() -> void:
	dialogue.get_v_scroll_bar().allow_greater = true
# This is where the actual dialogue rendering happens
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("interact"):
		if dialogue_count >= 0:# if dialogs have started, do this:
			var lines = dialogue.get_line_count()
			var scroll_bar = dialogue.get_v_scroll_bar()
			var max_scroll = scroll_bar.max_value
			var vis_lines = 3
			var ratio = max_scroll / lines
			dialogue_count += 1
			if dialogue_count >= lines - vis_lines or lines <= 3:
				continuation_indicator.visible = false
			if scroll_bar.value >= (lines - vis_lines) * ratio:
				hide_dialogue()# THis is the max number of lines dilogue can scroll
				dialogue_count = -1
				return
			var tween = get_tree().create_tween()
			tween.tween_property(scroll_bar,"value",dialogue_count * ratio,0.2)
			# If on last scroll remove the contonue indicator
			

func show_dialogue():
	name_label.text = "[center]" + owner.opponent_name
	dialogue.text = owner.pregame_dialogue
	if dialogue.get_line_count() <= 3:
		continuation_indicator.hide()
	modulate.a = 0
	show()
	get_tree().create_tween().tween_property(self,"modulate:a",1,0.2).set_trans(Tween.TRANS_LINEAR)
	dialogue_count += 1
	UIData.show_interact = false

func hide_dialogue():
	var tweener = get_tree().create_tween()
	tweener.tween_property(self,"modulate:a",0,0.5)
	await tweener.finished
	hide()
	UIData.show_interact = true
	continuation_indicator.show()
	dialogue_count = -1
	dialogue.get_v_scroll_bar().value = 0
	TempData.dialogue_complete.emit()
