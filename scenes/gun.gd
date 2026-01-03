extends RigidBody2D
var collected
var mouse
var box
var player
var charged
func _ready():
	charged = true
	for node in get_parent().get_children():
		if node.is_in_group("player_center"):
			player = node
	collected = true

func _process(delta):
	if box != null:
		position = box.get_parent().position + Vector2(-15, -20)
	if collected == true:
		rotation = 1
		charged = true
		sleeping = true
	else:
		sleeping = false
	if Input.is_action_pressed("left_mouse"):
		if mouse != null:
			look_at(player.position)
			rotation_degrees += 180
			follow_mouse(mouse.position)
	if Input.is_action_just_pressed("space"):
		if mouse != null:
			shoot()

func shoot():
	if charged == true:
		var bullet = load("res://scenes/bullet.tscn")
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation
		charged = false
		bullet_instance.position = position + transform.x * 40 + transform.y * -3
		print("Hola")
		add_sibling(bullet_instance)

	
func follow_mouse(mouse_position):
	position = mouse_position
	
func _on_mouse_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("mouse"):
		if area.picked == false:
			mouse = area
			mouse.picked = true
	if area.is_in_group("storage"):
		rotation += 5
		box = area
		mouse = null
		collected = true

func _on_mouse_collision_area_exited(area: Area2D) -> void:
	if area.is_in_group("mouse"):
		mouse = null
		area.picked = false
	if area.is_in_group("storage"):
		rotation_degrees = -180
		box = null
		collected = false
