extends CanvasLayer

@onready var keys: TextureRect = %Keys
@onready var temp_elements: Control = $TemporaryElements
@onready var space: TextureRect = %Space
@onready var menu: Panel = %Menu

var animator : AnimationsLibrary

func _ready() -> void:
	animator = AnimationsLibrary.new(menu)
	UIData.changed.connect(_refresh_ui_elements)

func _refresh_ui_elements():
	if not UIData.show_keys: animator.slide_down(keys,180,1)
	else: animator.slide_up(keys,0,1)
	if not UIData.show_interact: animator.slide_down(space,180,1)
	else: animator.slide_up(space,0,1)

func menu_button_pressed():
	if menu.modulate.a != 0:
		animator.fade_out(menu,0.2)
	else:
		animator.fade_in(menu,0.2)

## Class containing various animations to be used for animating UI elements
class AnimationsLibrary:
	var menu : Panel
	
	func _init(menu) -> void:
		self.menu = menu
	
	func slide_down(node : CanvasItem,final_val,duration : float):
		var animator : Tween = UIData.get_tree().create_tween()
		animator.tween_property(node,"position:y",final_val,duration).\
		set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

	func slide_up(node : CanvasItem,final_val, duration : float):
		var animator : Tween = UIData.get_tree().create_tween()
		animator.tween_property(node,"position:y",final_val,duration)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

	func fade_out(node : CanvasItem, duration : float):
		var animator : Tween = UIData.get_tree().create_tween()
		animator.tween_property(node,"modulate:a",0,duration).set_trans(Tween.TRANS_LINEAR)
		await animator.finished
		menu.hide()

	func fade_in(node : CanvasItem, duration : float):
		menu.show()
		var animator : Tween = UIData.get_tree().create_tween()
		animator.tween_property(node,"modulate:a",1,duration).set_trans(Tween.TRANS_LINEAR)


