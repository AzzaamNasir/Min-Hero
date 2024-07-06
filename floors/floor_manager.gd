extends Node2D

@export var hatchery_options : Array
@export var floor_map : Texture2D
@export var characters : Array

func _ready() -> void:
	DiscordRPC.app_id = 1258685490937462826
	DiscordRPC.details = "Godot Version"
	DiscordRPC.large_image = "grassseal"
	DiscordRPC.refresh()
