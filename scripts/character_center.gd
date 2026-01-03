extends RigidBody2D
var piolets = []
var arm_length = 200
var items = []
var last_piolet_position
func _ready():
	linear_velocity = Vector2(0, 0)
	for node in get_parent().get_children():
		if node.is_in_group("piolet"):
			piolets.append(node)
			
func _physics_process(delta):
	for piolet in piolets:
		piolet.linear_velocity = Vector2.ZERO
		if piolet.fixed == true:
			correct_position(piolet.anchored_position)
			
func correct_position(piolet):
	var W = piolet - position
	var distance = W.length()
	if abs(distance - arm_length) > 5:
		var correction = distance - arm_length
		linear_velocity += correction * W.normalized()
	else:
		var A = position
		var C = position + linear_velocity
		var P = punto_proyeccion(A, C, W)
		var V1 = [Vector2(P - A), Vector2(C - P)]
		linear_velocity = V1[1]

func punto_proyeccion(A, C, W):
	var W2 = W.length_squared()
	if W2 == 0:
		return A
	var t = (C - A).dot(W) / W2
	var P = A + W * t
	return P


func _on_storage_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Collectable"):
		linear_velocity = Vector2.ZERO
		area.get_parent().collected = false
		print(piolets[1].position)
		items.erase(area)
		piolets[1].position = position + Vector2(100, 500)
		piolets[1].fixed = true
		piolets[1].sleeping = true
		piolets[1].rotation_degrees = 0

func _on_storage_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Collectable"):
		area.get_parent().collected = true
		items.append(area)
		piolets[1].fixed = false
		piolets[1].sleeping = false
		piolets[1].anchored = true
