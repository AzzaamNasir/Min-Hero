extends Panel
class_name OpponentDialogue
## manages the dialogs

# This can be used to check whether the end of label has been reached
var dialogue_count := -1
# Label on which name is drawn
@onready var name_label: RichTextLabel = $Name
# Label on which dialogue is written
@onready var dialogue: RichTextLabel = $Dialogue
# The small arrow which tells you if there is more text
@onready var continuation_indicator: TextureRect = $ContinuationIndicator

func _ready() -> void:
	modulate.a = 0
	dialogue.get_v_scroll_bar().allow_greater = true
	TranslationServer.set_locale("en")

# This is where the actual dialogue rendering happens
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if dialogue_count >= 0:# if dialogs have started, do this:
			var lines = dialogue.get_line_count() # Get number of lines in dialogue
			var scroll_bar = dialogue.get_v_scroll_bar() # Get the imaginary "scroll bar"
			var max_scroll = scroll_bar.max_value # max value of the scroll bar
			var vis_lines = 3 # How many lines are visible at once
			var ratio = max_scroll / lines # How much to scroll for each line
			dialogue_count += 1 
			
			if dialogue_count >= lines - vis_lines or lines <= 3:
				continuation_indicator.visible = false # If not reached end of dialogue
			
			if scroll_bar.value >= (lines - vis_lines) * ratio:
				hide_dialogue()
				dialogue_count = -1
				return
			# Animate text to scroll down
			var tween = get_tree().create_tween()
			tween.tween_property(scroll_bar,"value",dialogue_count * ratio,0.2)

func show_dialogue(speaker : String, dialogue_text : String):
	name_label.text = "[center]" + speaker
	dialogue.text = tr(dialogue_text)
	if dialogue.get_line_count() <= 3:
		continuation_indicator.hide()
	# Lines below: Animate the dialogue to fade in
	modulate.a = 0
	show()
	get_tree().create_tween().tween_property(self,"modulate:a",1,0.2).set_trans(Tween.TRANS_LINEAR)
	dialogue_count += 1
	UIData.show_interact = false

func hide_dialogue():
	# fade out dialogue
	SignalBus.dialogue_complete.emit()
	UIData.show_interact = true
	var tweener = get_tree().create_tween()
	tweener.tween_property(self,"modulate:a",0,0.5)
	await tweener.finished
	hide()
	continuation_indicator.show()
	dialogue_count = -1
	dialogue.get_v_scroll_bar().value = 0
