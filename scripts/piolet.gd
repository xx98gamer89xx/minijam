extends RigidBody2D
var mouse_position
var mouse
var player
var anchored
var anchored_position
var terrain
func _ready() -> void:
	anchored_position = position
	anchored = true
	for node in get_parent().get_children():
		if node.is_in_group("player_center"):
			player = node

func _process(delta: float) -> void:
	if terrain == "normal" or terrain == null:
		pass
	if terrain == "gravel":
		position.y -= 1
	if Input.is_action_pressed("left_mouse"):
		if mouse != null:
			anchored = false
			if mouse.position.distance_to(player.position) < player.arm_length * 1.35 and mouse.position.distance_to(player.position) > 90:
				follow_mouse(mouse.position)
	else:
		anchored = true
	if anchored == true:
		anchored_position = position
	else:
		print("Está suelto")
		
func follow_mouse(mouse_position):
	position = mouse_position

func _on_mouse_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("mouse"):
		mouse = area


func _on_mouse_collision_area_exited(area: Area2D) -> void:
	if area.is_in_group("mouse"):
		mouse = null

func _on_piolet_collision_area_exited(area: Area2D) -> void:
	if area.is_in_group("terrain"):
		terrain = null

func _on_piolet_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("terrain"):
		terrain = area.terrain
