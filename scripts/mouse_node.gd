extends Area2D
var picked
func _ready():
	picked = false
func _process(delta):
	position = get_global_mouse_position()
