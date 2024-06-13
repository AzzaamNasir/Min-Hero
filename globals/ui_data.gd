extends Node

signal changed

@export var show_keys := true:
	set(value):
		show_keys = value
		changed.emit()

@export var show_interact := false:
	set(value):
		if value != show_interact:
			show_interact = value
			changed.emit()
