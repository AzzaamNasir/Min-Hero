extends Sprite2D

## Controls the rarity of background element
@export var gap := 0.0
## Controls speed of background element
@export var speed_scale := 1.0

## Just returns the right edge of the element
var right : float:
	get:
		return position.x + (get_rect().size.x * scale.x)
